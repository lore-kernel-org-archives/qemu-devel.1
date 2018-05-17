Received: from eggs.gnu.org ([2001:4830:134:3::10]:33938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fJK1m-0003CD-AA
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fJK1i-0002To-T7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:37:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33365
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fJK1i-0002Tg-Mm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:37:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4HEVsjF003003
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:37:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j1baph717-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:37:05 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Thu, 17 May 2018 08:37:04 -0600
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Thu, 17 May 2018 22:36:57 +0800
MIME-Version: 1.0
In-Reply-To: <20180517124109.GJ17734@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a3595950-e669-a6ca-d8a6-8426aee1b790@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com



=E5=9C=A8 2018/5/17 =E4=B8=8B=E5=8D=888:41, Eduardo Otubo =E5=86=99=E9=81=
=93:
> On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
>> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>> compiled. This would make libvirt set the corresponding capability and
>> then trigger the guest startup fails. So this patch excludes the code
>> regarding seccomp staff if CONFIG_SECCOMP is undefined.
> Just a sugestion for the next patch you send: If it's a single patch, y=
ou don't
> need to format it with a cover-letter. Just put all the description in =
the body,
> or if you need to add a text that shouldn't be included in the commit m=
essage,
> just add it after the "---" after Signed-off-by.
OK. Thanks for your suggestion.
>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> ---
>>   vl.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 806eec2ef6..b22d158f5f 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -257,6 +257,7 @@ static QemuOptsList qemu_rtc_opts =3D {
>>       },
>>   };
>>  =20
>> +#ifdef CONFIG_SECCOMP
>>   static QemuOptsList qemu_sandbox_opts =3D {
>>       .name =3D "sandbox",
>>       .implied_opt_name =3D "enable",
>> @@ -285,6 +286,7 @@ static QemuOptsList qemu_sandbox_opts =3D {
>>           { /* end of list */ }
>>       },
>>   };
>> +#endif
>>  =20
>>   static QemuOptsList qemu_option_rom_opts =3D {
>>       .name =3D "option-rom",
>> @@ -1041,10 +1043,10 @@ static int bt_parse(const char *opt)
>>       return 1;
>>   }
>>  =20
>> +#ifdef CONFIG_SECCOMP
>>   static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>>   {
>>       if (qemu_opt_get_bool(opts, "enable", false)) {
>> -#ifdef CONFIG_SECCOMP
>>           uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
>>                   | QEMU_SECCOMP_SET_OBSOLETE;
>>           const char *value =3D NULL;
>> @@ -1114,14 +1116,11 @@ static int parse_sandbox(void *opaque, QemuOpt=
s *opts, Error **errp)
>>                            "in the kernel");
>>               return -1;
>>           }
>> -#else
>> -        error_report("seccomp support is disabled");
>> -        return -1;
>> -#endif
> Any reason not to keep the error message on the new #endif location?
If error report is originally wrapped in CONFIG_SECCOMP undefined.
This patch excludes the entire function if CONFIG_SECCOMP is undefined.
So the error report is not needed.
>
>>       }
>>  =20
>>       return 0;
>>   }
>> +#endif
>>  =20
>>   static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
>>   {
>> @@ -3074,7 +3073,9 @@ int main(int argc, char **argv, char **envp)
>>       qemu_add_opts(&qemu_mem_opts);
>>       qemu_add_opts(&qemu_smp_opts);
>>       qemu_add_opts(&qemu_boot_opts);
>> +#ifdef CONFIG_SECCOMP
>>       qemu_add_opts(&qemu_sandbox_opts);
>> +#endif
>>       qemu_add_opts(&qemu_add_fd_opts);
>>       qemu_add_opts(&qemu_object_opts);
>>       qemu_add_opts(&qemu_tpmdev_opts);
>> @@ -4071,10 +4072,12 @@ int main(int argc, char **argv, char **envp)
>>           exit(1);
>>       }
>>  =20
>> +#ifdef CONFIG_SECCOMP
>>       if (qemu_opts_foreach(qemu_find_opts("sandbox"),
>>                             parse_sandbox, NULL, NULL)) {
>>           exit(1);
>>       }
>> +#endif
>>  =20
>>       if (qemu_opts_foreach(qemu_find_opts("name"),
>>                             parse_name, NULL, NULL)) {
>> --=20
>> Yi Min
>>
> I just wanted a review from J=C3=A1n, since he is the author of the ori=
ginal libvirt
> patch. Does this breaks libvirt logic in any way? If not, ACK on this p=
atch.
>
>
OK.
