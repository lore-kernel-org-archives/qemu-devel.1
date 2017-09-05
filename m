Received: from eggs.gnu.org ([2001:4830:134:3::10]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thgarnie@google.com>) id 1dpIW2-00032Q-8m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thgarnie@google.com>) id 1dpIVx-0008U4-HE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:24:02 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thgarnie@google.com>) id 1dpIVx-0008Tt-C7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:23:57 -0400
Received: by mail-io0-x230.google.com with SMTP id z67so19298580iof.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:23:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJcbSZE-+tKhDiF2m3+rH+ynsdLbWXf=ukMm_XSv+7F76-4WdA@mail.gmail.com>
References: <20170905174942.3094-1-ppandit@redhat.com>
	<CAJcbSZE-+tKhDiF2m3+rH+ynsdLbWXf=ukMm_XSv+7F76-4WdA@mail.gmail.com>
From: Thomas Garnier <thgarnie@google.com>
Date: Tue, 5 Sep 2017 11:23:55 -0700
Message-ID: <CAJcbSZERvq+-w4WMhFK5m4yHdXf8T-yyhXNmadu2eES4YZGM5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] multiboot: validate multiboot header
 address values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Sep 5, 2017 at 11:12 AM, Thomas Garnier <thgarnie@google.com> wrote:
> On Tue, Sep 5, 2017 at 10:49 AM, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While loading kernel via multiboot-v1 image, (flags & 0x00010000)
>> indicates that multiboot header contains valid addresses to load
>> the kernel image. These addresses are used to compute kernel
>> size and kernel text offset in the OS image. Validate these
>> address values to avoid an OOB access issue.
>>
>> Reported-by: Thomas Garnier <thgarnie@google.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>
> Looks good, tested.
>
> Tested-by: Thomas Garnier <thgarnie@google.com>

Btw, can you open a CVE for that? (and reference it in the commit).

>
>>  hw/i386/multiboot.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>> index 6001f4caa2..c7b70c91d5 100644
>> --- a/hw/i386/multiboot.c
>> +++ b/hw/i386/multiboot.c
>> @@ -221,15 +221,34 @@ int load_multiboot(FWCfgState *fw_cfg,
>>          uint32_t mh_header_addr = ldl_p(header+i+12);
>>          uint32_t mh_load_end_addr = ldl_p(header+i+20);
>>          uint32_t mh_bss_end_addr = ldl_p(header+i+24);
>> +
>>          mh_load_addr = ldl_p(header+i+16);
>> +        if (mh_header_addr < mh_load_addr) {
>> +            fprintf(stderr, "invalid mh_load_addr address\n");
>> +            exit(1);
>> +        }
>> +
>>          uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
>>          uint32_t mb_load_size = 0;
>>          mh_entry_addr = ldl_p(header+i+28);
>>
>>          if (mh_load_end_addr) {
>> +            if (mh_bss_end_addr < mh_load_addr) {
>> +                fprintf(stderr, "invalid mh_bss_end_addr address\n");
>> +                exit(1);
>> +            }
>>              mb_kernel_size = mh_bss_end_addr - mh_load_addr;
>> +
>> +            if (mh_load_end_addr < mh_load_addr) {
>> +                fprintf(stderr, "invalid mh_load_end_addr address\n");
>> +                exit(1);
>> +            }
>>              mb_load_size = mh_load_end_addr - mh_load_addr;
>>          } else {
>> +            if (kernel_file_size < mb_kernel_text_offset) {
>> +                fprintf(stderr, "invalid kernel_file_size\n");
>> +                exit(1);
>> +            }
>>              mb_kernel_size = kernel_file_size - mb_kernel_text_offset;
>>              mb_load_size = mb_kernel_size;
>>          }
>> --
>> 2.13.5
>>
>
>
>
> --
> Thomas



-- 
Thomas
