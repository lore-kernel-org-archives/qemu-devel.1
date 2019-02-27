Received: from eggs.gnu.org ([209.51.188.92]:35642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gypZf-0000zE-1v
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 22:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gypZV-0001O0-9z
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 22:07:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:18081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gypZT-0001Lj-4Q
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 22:07:49 -0500
Date: Wed, 27 Feb 2019 11:07:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190227030715.GA5449@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
	<bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, somlo@cmu.edu, mst@redhat.com

On Tue, Feb 26, 2019 at 07:45:46PM +0100, Philippe Mathieu-Daudé wrote:
>Hi Wei,
>
>On 2/26/19 8:31 AM, Wei Yang wrote:
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
>
>Why not keep S_IRUSR?
>

Because scripts/checkpatch.pl suggest not use S_IRUSR :-)

I am not sure about the particular reason.

>>  
>>  /* fw_cfg_sysfs_entry type */
>>  struct fw_cfg_sysfs_entry {
>> 

-- 
Wei Yang
Help you, Help me
