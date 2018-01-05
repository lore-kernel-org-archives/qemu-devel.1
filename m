Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eXVxY-0002cz-Um
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eXVxV-0000Lh-Of
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:39:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1eXVxV-0000L1-Ai
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:39:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D70C6C0E
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:39:07 +0000 (UTC)
References: <1513370232-25515-1-git-send-email-wei@redhat.com>
	<87po6pz8pg.fsf@secure.laptop>
From: Wei Huang <wei@redhat.com>
Message-ID: <c11296c9-29aa-0401-dc65-76c5ef2eea08@redhat.com>
Date: Fri, 5 Jan 2018 11:39:05 -0600
MIME-Version: 1.0
In-Reply-To: <87po6pz8pg.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>



On 01/04/2018 02:10 PM, Juan Quintela wrote:
> Wei Huang <wei@redhat.com> wrote:
>> This patch adds the migration test support for aarch64. The test code,
>> which implements the same functionality as x86, is compiled into a binary
>> and booted as a kernel to qemu. Here are the design ideas:
>>
>> * We choose this -kernel design because aarch64 QEMU doesn't provide a
>>   built-in fw like x86 does. So instead of relying on a boot loader, we
>>   use -kernel approach for aarch64.
>> * The serial output is sent to PL011 directly.
>> * The physical memory base for mach-virt machine is 0x40000000. We have
>>   to change the start_address and end_address for aarch64.
>> * The downtime is changed from 0.001 to 0.1. Without this change, we saw
>>   migration stalled. This problem is still under analysis and needs to be
>>   resolved before removing RFC for this patch.
> 
> 
> Hi
> 
> I don't have a good solution for how to go from ASM -> binary array, I
> think that Dave suggestion is good.

This is related to a bug Dave Gilbert recently fixed. The reason is
because there were 16 4K dirty pages unaccounted during migration. It is
impossible to migrate them under 0.001 downtime. We are good now with
this issue now.

> 
>>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>>  
>>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>>  
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index be598d3..b0dd365 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -22,8 +22,8 @@
>>  
>>  #define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
>>  
>> -const unsigned start_address = 1024 * 1024;
>> -const unsigned end_address = 100 * 1024 * 1024;
>> +unsigned start_address = 1024 * 1024;
>> +unsigned end_address = 100 * 1024 * 1024;
>>  bool got_stop;
>>  
>>  #if defined(__linux__)
>> @@ -125,6 +125,18 @@ unsigned char bootsect[] = {
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
>>  };
>>  
>> +unsigned char aarch64_kernel[] = {
>> +    0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
>> +    0xdf, 0x3f, 0x03, 0xd5, 0x24, 0x08, 0x80, 0x52, 0x05, 0x20, 0xa1, 0xd2,
>> +    0xa4, 0x00, 0x00, 0x39, 0x06, 0x00, 0x80, 0x52, 0x03, 0xc8, 0xa8, 0xd2,
>> +    0x02, 0x02, 0xa8, 0xd2, 0x41, 0x00, 0x40, 0x39, 0x21, 0x04, 0x00, 0x11,
>> +    0x41, 0x00, 0x00, 0x39, 0x42, 0x04, 0x40, 0x91, 0x5f, 0x00, 0x03, 0xeb,
>> +    0x6b, 0xff, 0xff, 0x54, 0xc6, 0x04, 0x00, 0x11, 0xc6, 0x1c, 0x00, 0x12,
>> +    0xdf, 0x00, 0x00, 0x71, 0xc1, 0xfe, 0xff, 0x54, 0x44, 0x08, 0x80, 0x52,
>> +    0x05, 0x20, 0xa1, 0xd2, 0xa4, 0x00, 0x00, 0x39, 0xf2, 0xff, 0xff, 0x97
>> +};
>> +unsigned int aarch64_kernel_len = 96;
> 
> Just wondering, what is wrong with sizeof(aarch64_kernel)?
> 
> (Yes, existing code already do it this bad.)
> 

Yes, we can fix both of them together.

> 
> 
> 
>> +
>>  static void init_bootfile_x86(const char *bootpath)
>>  {
>>      FILE *bootfile = fopen(bootpath, "wb");
>> @@ -163,6 +175,15 @@ static void init_bootfile_ppc(const char *bootpath)
>>      fclose(bootfile);
>>  }
>>  
>> +static void init_bootfile_aarch64(const char *bootpath)
>> +{
>> +    FILE *kernelfile = fopen(bootpath, "wb");
>> +
>> +    g_assert_cmpint(fwrite(aarch64_kernel, aarch64_kernel_len, 1, kernelfile),
>> +                    ==, 1);
>> +    fclose(kernelfile);
>> +}
> 
> This function is identical to init_bootfile_x86(), just that we are
> using aarch64_kernel instead of bootsect.  Would be a good idea to
> abstract it?

Sure

> 
>> @@ -470,6 +491,22 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>>                                    " -serial file:%s/dest_serial"
>>                                    " -incoming %s",
>>                                    accel, tmpfs, uri);
>> +    } else if (strcmp(arch, "aarch64") == 0) {
>> +        init_bootfile_aarch64(bootpath);
>> +        cmd_src = g_strdup_printf("-machine virt,accel=kvm:cg -m
>>                                    1024M"
> 
> We are missing a "t" in "tcg", right?
> 
> I see that PC uses 150M, PPC uses 256M and now arm uses 1G.  Any reason
> for that?

It should be kvm:tcg in this case. Also my goal is to use 150M for
AArch64. But I was facing another issue (under debug) which made me to
try different memory sizes. The final version will use 150M.

> 
> 
>> +                                  " -name vmsource,debug-threads=on -cpu host"
>> +                                  " -serial file:%s/src_serial "
>> +                                  " -kernel %s ",
>> +                     x             tmpfs, bootpath);
>> +        cmd_dst = g_strdup_printf("-machine virt,accel=kvm:tcg -m 1024M"
>> +                                  " -name vmdest,debug-threads=on -cpu host"
>> +                                  " -serial file:%s/dest_serial"
>> +                                  " -kernel %s"
>> +                                  " -incoming %s",
>> +                                  tmpfs, bootpath, uri);
>> +        /* aarch64 virt machine physical mem started from 0x40000000 */
>> +        start_address += 0x40000000;
>> +        end_address += 0x40000000;
>>      } else {
>>          g_assert_not_reached();
>>      }
>> @@ -530,7 +567,7 @@ static void test_migrate(void)
>>       * machine, so also set the downtime.
>>       */
>>      migrate_set_speed(from, "100000000");
>> -    migrate_set_downtime(from, 0.001);
>> +    migrate_set_downtime(from, 0.1);
> 
> Why?  I guess this is a leftover from previous versions of upstream and
> can be dropped.

According to Dave, migrate_set_downtime(from, 0.001) is to force
postcopy. But on aarch64, it can't pass. So I had to use 0.1
temporarily. Dave had fixed it (see above).

> 
> 
>>      /* Wait for the first serial output from the source */
>>      wait_for_serial("src_serial");
> 
> I agree with the patch in general, only the two nickpits that I pointed
> need to be changed.
> 
> 
> But once that everybody is looking, I would like to open a discussion
> about how to make more abstract this test, and not adding so many bits
> each time that we need to create a new machine.

The test cases themselves are the most annoying ones. x86/aarch64 use
assembly (converted to binaries); but ppc uses scripts. How to find a
common solution to suite all arch's?

> 
> And once that we are here, I *think* that the ppc test is wrong, it is
> missing the -drive-file on destination, no?

[cc'ing Laurent]

> 
> And once here, does -cpu host make sense only for arm, or should we do
> it for all archs?

I think x86 and aarch64 are OK with it. But I am not sure about PPC.

> 
> Thanks, Juan.
> 
