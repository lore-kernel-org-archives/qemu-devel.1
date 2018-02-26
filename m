Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqOTG-0008O8-Kj
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqOTB-0005xY-N1
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:29:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eqOTB-0005xO-EK
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 14:29:53 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1QJNefS128686
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:29:51 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gcp5pdj3u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:29:51 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 26 Feb 2018 14:29:49 -0500
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
	<20180226194857.01ce4a8c.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 14:29:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180226194857.01ce4a8c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL-for-s390x 06/14] s390-ccw:
 parse and set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 02/26/2018 01:48 PM, Cornelia Huck wrote:
> On Mon, 26 Feb 2018 11:42:29 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>
>> Set boot menu options for an s390 guest and store them in
>> the iplb. These options are set via the QEMU command line
>> option:
>>
>>      -boot menu=on|off[,splash-time=X]
>>
>> or via the libvirt domain xml:
>>
>>      <os>
>>        <bootmenu enable='yes|no' timeout='X'/>
>>      </os>
>>
>> Where X represents some positive integer representing
>> milliseconds.
>>
>> Any value set for loadparm will override all boot menu options.
>> If loadparm=PROMPT, then the menu will be enabled without a
>> timeout.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/ipl.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/s390x/ipl.h          |  9 +++++++--
>>   pc-bios/s390-ccw/iplb.h |  9 +++++++--
> Updating the header, but it is not consumed in the bios?
>
>>   3 files changed, 66 insertions(+), 4 deletions(-)
>> +static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>> +{
>> +    QemuOptsList *plist = qemu_find_opts("boot-opts");
>> +    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
>> +    uint8_t *flags = &ipl->qipl.qipl_flags;
>> +    uint32_t *timeout = &ipl->qipl.boot_menu_timeout;
>> +    const char *tmp;
>> +    unsigned long splash_time = 0;
>> +
>> +    if (!get_boot_device(0)) {
>> +        if (boot_menu) {
>> +            error_report("boot menu requires a bootindex to be specified for "
>> +                         "the IPL device.");
>> +        }
>> +        return;
>> +    }
>> +
>> +    switch (ipl->iplb.pbt) {
>> +    case S390_IPL_TYPE_CCW:
>> +        break;
>> +    default:
>> +        error_report("boot menu is not supported for this device type.");
> If I specify both a bootindex for a device and a -kernel parameter, I
> get this error message. Looks a tad odd, but not sure how to avoid it.

Hmm... perhaps an additional check if no IPLB, then skip trying to set
any boot menu data?

> [...]


-- 
- Collin L Walling
