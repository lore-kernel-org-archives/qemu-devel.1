Received: from eggs.gnu.org ([2001:4830:134:3::10]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emiYz-0000iz-Gx
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emiYw-0008S9-9j
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:08:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54546
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emiYw-0008Rb-2h
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:08:38 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GG6M0I077382
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:08:37 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5y6krv0w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:08:36 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 11:08:35 -0500
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-5-git-send-email-walling@linux.vnet.ibm.com>
	<5e2a07bc-6ba4-14c4-96d0-347455ec0997@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 11:08:31 -0500
MIME-Version: 1.0
In-Reply-To: <5e2a07bc-6ba4-14c4-96d0-347455ec0997@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b7c0b02e-299f-3f8c-61a3-233e45ebfa33@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 04/12] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/16/2018 11:05 AM, Thomas Huth wrote:
> On 15.02.2018 23:54, Collin L. Walling wrote:
>> Moved:
>>    memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>    strlen from sclp.c to libc.h (renamed from _strlen)
> What happened to the renames of _strlen to strlen and _memcmp to memcmp?
> The hunks now seem to be missing from this patch? Or do I miss something?
>
>   Thomas

Oh shoot... yeah, the _* functions didn't seem to get removed...
sorry about that. Odd rebasing failure on my end :(

>
>
>> Added C standard functions:
>>    isdigit
>>
>> Added non C-standard function:
>>    uitoa
>>    atoui
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/Makefile |  2 +-
>>   pc-bios/s390-ccw/libc.c   | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/libc.h   | 37 ++++++++++++++++++--
>>   pc-bios/s390-ccw/main.c   | 17 +--------
>>   4 files changed, 126 insertions(+), 19 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/libc.c
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 6d0c2ee..9f7904f 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>>   
>>   .PHONY : all clean build-all
>>   
>> -OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
>> +OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o
>>   QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>>   QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>>   QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
>> diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
>> new file mode 100644
>> index 0000000..a144388
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/libc.c
>> @@ -0,0 +1,89 @@
>> +/*
>> + * libc-style definitions and functions
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Collin L. Walling <walling@linux.vnet.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version 2 of the License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include "libc.h"
>> +#include "s390-ccw.h"
>> +
>> +/**
>> + * atoui:
>> + * @str: the string to be converted.
>> + *
>> + * Given a string @str, convert it to an integer. Leading spaces are
>> + * ignored. Any other non-numerical value will terminate the conversion
>> + * and return 0. This function only handles numbers between 0 and
>> + * UINT64_MAX inclusive.
>> + *
>> + * Returns: an integer converted from the string @str, or the number 0
>> + * if an error occurred.
>> + */
>> +uint64_t atoui(const char *str)
>> +{
>> +    int val = 0;
>> +
>> +    if (!str || !str[0]) {
>> +        return 0;
>> +    }
>> +
>> +    while (*str == ' ') {
>> +        str++;
>> +    }
>> +
>> +    while (*str) {
>> +        if (!isdigit(*str)) {
>> +            break;
>> +        }
>> +        val = val * 10 + *str - '0';
>> +        str++;
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +/**
>> + * uitoa:
>> + * @num: an integer (base 10) to be converted.
>> + * @str: a pointer to a string to store the conversion.
>> + * @len: the length of the passed string.
>> + *
>> + * Given an integer @num, convert it to a string. The string @str must be
>> + * allocated beforehand. The resulting string will be null terminated and
>> + * returned. This function only handles numbers between 0 and UINT64_MAX
>> + * inclusive.
>> + *
>> + * Returns: the string @str of the converted integer @num
>> + */
>> +char *uitoa(uint64_t num, char *str, size_t len)
>> +{
>> +    size_t num_idx = 0;
>> +    uint64_t tmp = num;
>> +
>> +    IPL_assert(str != NULL, "uitoa: no space allocated to store string");
>> +
>> +    /* Get index to ones place */
>> +    while ((tmp /= 10) != 0) {
>> +        num_idx++;
>> +    }
>> +
>> +    /* Check if we have enough space for num and null */
>> +    IPL_assert(len > num_idx, "uitoa: array too small for conversion");
>> +
>> +    str[num_idx + 1] = '\0';
>> +
>> +    /* Convert int to string */
>> +    while (num_idx >= 0) {
>> +        str[num_idx] = num % 10 + '0';
>> +        num /= 10;
>> +        num_idx--;
>> +    }
>> +
>> +    return str;
>> +}
>> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
>> index 0142ea8..63ece70 100644
>> --- a/pc-bios/s390-ccw/libc.h
>> +++ b/pc-bios/s390-ccw/libc.h
>> @@ -1,6 +1,8 @@
>>   /*
>>    * libc-style definitions and functions
>>    *
>> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
>> + *
>>    * This code is free software; you can redistribute it and/or modify it
>>    * under the terms of the GNU General Public License as published by the
>>    * Free Software Foundation; either version 2 of the License, or (at your
>> @@ -19,7 +21,7 @@ typedef unsigned long long uint64_t;
>>   
>>   static inline void *memset(void *s, int c, size_t n)
>>   {
>> -    int i;
>> +    size_t i;
>>       unsigned char *p = s;
>>   
>>       for (i = 0; i < n; i++) {
>> @@ -33,7 +35,7 @@ static inline void *memcpy(void *s1, const void *s2, size_t n)
>>   {
>>       uint8_t *dest = s1;
>>       const uint8_t *src = s2;
>> -    int i;
>> +    size_t i;
>>   
>>       for (i = 0; i < n; i++) {
>>           dest[i] = src[i];
>> @@ -42,4 +44,35 @@ static inline void *memcpy(void *s1, const void *s2, size_t n)
>>       return s1;
>>   }
>>   
>> +static inline int memcmp(const void *s1, const void *s2, size_t n)
>> +{
>> +    size_t i;
>> +    const uint8_t *p1 = s1, *p2 = s2;
>> +
>> +    for (i = 0; i < n; i++) {
>> +        if (p1[i] != p2[i]) {
>> +            return p1[i] > p2[i] ? 1 : -1;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static inline size_t strlen(const char *str)
>> +{
>> +    size_t i;
>> +    for (i = 0; *str; i++) {
>> +        str++;
>> +    }
>> +    return i;
>> +}
>> +
>> +static inline int isdigit(int c)
>> +{
>> +    return (c >= '0') && (c <= '9');
>> +}
>> +
>> +uint64_t atoui(const char *str);
>> +char *uitoa(uint64_t num, char *str, size_t len);
>> +
>>   #endif
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 401e9db..e857ce4 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -40,22 +40,7 @@ void panic(const char *string)
>>   
>>   unsigned int get_loadparm_index(void)
>>   {
>> -    const char *lp = loadparm;
>> -    int i;
>> -    unsigned int idx = 0;
>> -
>> -    for (i = 0; i < 8; i++) {
>> -        char c = lp[i];
>> -
>> -        if (c < '0' || c > '9') {
>> -            break;
>> -        }
>> -
>> -        idx *= 10;
>> -        idx += c - '0';
>> -    }
>> -
>> -    return idx;
>> +    return atoui(loadparm);
>>   }
>>   
>>   static bool find_dev(Schib *schib, int dev_no)
>>
>


-- 
- Collin L Walling
