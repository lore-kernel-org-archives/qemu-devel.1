Received: from eggs.gnu.org ([2001:4830:134:3::10]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecYFC-0001Ca-Lg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecYF9-0002FM-AV
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:06:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ecYF9-0002Dw-2T
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:06:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JF2JCc072258
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:06:09 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkhk5bw5w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:06:09 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 08:06:08 -0700
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<151637257830.599.12053715954868331479@5adcb62bf0d6>
	<CAMxuvawiLgNL9UGORr2chS7m6YqckB+UuSPh4Gk5iuzx_wGrtA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 10:06:05 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvawiLgNL9UGORr2chS7m6YqckB+UuSPh4Gk5iuzx_wGrtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <702550e1-2432-beee-c031-9d46592aeacb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tpm: CRB device and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: marcandre <marcandre.lureau@redhat.com>, famz@redhat.com

On 01/19/2018 09:56 AM, Marc-Andre Lureau wrote:
> On Fri, Jan 19, 2018 at 3:36 PM,  <no-reply@patchew.org> wrote:
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c: In function 'tpm_crb_mmio_read':
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:126:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>>       DPRINTF("CRB read 0x%lx:%s len:%u\n",
>>               ^
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>>               printf(fmt, ## __VA_ARGS__);        \
>>                      ^~~
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c: In function 'tpm_crb_mmio_write':
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:146:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>>       DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
>>               ^
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>>               printf(fmt, ## __VA_ARGS__);        \
>>                      ^~~
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:146:13: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>>       DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
>>               ^
>> /tmp/qemu-test/src/hw/tpm/tpm_crb.c:48:20: note: in definition of macro 'DPRINTF'
>>               printf(fmt, ## __VA_ARGS__);        \
>>                      ^~~
> This will fix it:
> Stefan feel free to squash it if no further changes required

Will do. Thanks.

>
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -123,7 +123,7 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>                                     unsigned size)
>   {
>       CRBState *s = CRB(opaque);
> -    DPRINTF("CRB read 0x%lx:%s len:%u\n",
> +    DPRINTF("CRB read 0x" TARGET_FMT_plx ":%s len:%u\n",
>               addr, addr_desc(addr), size);
>       void *regs = (void *)&s->regs + addr;
>
> @@ -143,7 +143,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                  uint64_t val, unsigned size)
>   {
>       CRBState *s = CRB(opaque);
> -    DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
> +    DPRINTF("CRB write 0x" TARGET_FMT_plx ":%s len:%u val:%" PRIu64 "\n",
>               addr, addr_desc(addr), size, val);
>
>       switch (addr) {
>
