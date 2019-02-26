Received: from eggs.gnu.org ([209.51.188.92]:36988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhlY-000401-PT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhlX-000497-Dy
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:47:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyhlV-00045b-C4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:47:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so15172937wrw.0
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:47:37 -0800 (PST)
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
	<20190226110934-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <683d6fc9-bfdc-b2e5-e1b7-cd2d2711268e@redhat.com>
Date: Tue, 26 Feb 2019 19:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190226110934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org

On 2/26/19 5:10 PM, Michael S. Tsirkin wrote:
> On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
>> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
>> to define the attribute.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> index 039e0f91dba8..a1293cbd7adb 100644
>> --- a/drivers/firmware/qemu_fw_cfg.c
>> +++ b/drivers/firmware/qemu_fw_cfg.c
>> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
>> +			       char *buf)
>>  {
>>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>>  }
>> -
>> -static const struct {
>> -	struct attribute attr;
>> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
>> -} fw_cfg_rev_attr = {
>> -	.attr = { .name = "rev", .mode = S_IRUSR },
>> -	.show = fw_cfg_showrev,
>> -};
>> +static const struct kobj_attribute fw_cfg_rev_attr =
>> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>>  
>>  /* fw_cfg_sysfs_entry type */
>>  struct fw_cfg_sysfs_entry {
> 
> 
> Looks like this will change the name from "rev" to "fw_cfg_rev".
> That's a userspace visible change which we should not do lightly.

We could name the function rev_show but this stay fragile, we'd also
need a comment "don't rename this".

>> -- 
>> 2.19.1
> 
