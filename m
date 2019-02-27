Received: from eggs.gnu.org ([209.51.188.92]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gz0Eg-0000ZI-PH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gz0Au-0005zf-39
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:27:08 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1gz0At-0005op-SL
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:27:08 -0500
Received: by mail-ed1-x541.google.com with SMTP id a16so14075452edn.1
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 06:26:54 -0800 (PST)
Date: Wed, 27 Feb 2019 14:26:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190227142651.3enr2eey5bn2v6ls@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
	<20190226110934-mutt-send-email-mst@kernel.org>
	<20190227053319.GB5449@richard>
	<20190227084843-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227084843-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, somlo@cmu.edu, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:51:11AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 27, 2019 at 01:33:19PM +0800, Wei Yang wrote:
>> On Tue, Feb 26, 2019 at 11:10:06AM -0500, Michael S. Tsirkin wrote:
>> >On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
>> >> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
>> >> to define the attribute.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>> >>  1 file changed, 4 insertions(+), 9 deletions(-)
>> >> 
>> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> >> index 039e0f91dba8..a1293cbd7adb 100644
>> >> --- a/drivers/firmware/qemu_fw_cfg.c
>> >> +++ b/drivers/firmware/qemu_fw_cfg.c
>> >> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>> >>  	return 0;
>> >>  }
>> >>  
>> >> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>> >> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
>> >> +			       char *buf)
>> >>  {
>> >>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>> >>  }
>> >> -
>> >> -static const struct {
>> >> -	struct attribute attr;
>> >> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
>> >> -} fw_cfg_rev_attr = {
>> >> -	.attr = { .name = "rev", .mode = S_IRUSR },
>> >> -	.show = fw_cfg_showrev,
>> >> -};
>> >> +static const struct kobj_attribute fw_cfg_rev_attr =
>> >> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>> >>  
>> >>  /* fw_cfg_sysfs_entry type */
>> >>  struct fw_cfg_sysfs_entry {
>> >
>> >
>> >Looks like this will change the name from "rev" to "fw_cfg_rev".
>> >That's a userspace visible change which we should not do lightly.
>> 
>> You are right, I should keep the interface untouched.
>> 
>> To keep it user un-visible, we could change like below:
>> 
>> -       __ATTR_RO(fw_cfg_rev);
>> +       __ATTR_RO(rev);
>> 
>> Is this better for you?
>
>
>Also why use 0400 and not S_IRUSR?
>

This is interesting. The scripts/checkpatch.pl suggest to use 0400.

I am not sure why the script give this suggestion. Maybe we need to fix
the script?

>> >> -- 
>> >> 2.19.1
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me
