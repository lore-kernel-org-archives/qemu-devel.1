Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E07C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9642B20768
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="daab56cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9642B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLsyk-0003c8-Mj
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLsxo-0002fo-VB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLsxn-0002rt-Fv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:28:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joao.m.martins@oracle.com>)
 id 1jLsxn-0002rK-78
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:28:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037IHwkY041134;
 Tue, 7 Apr 2020 18:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7bCTxY1yhPzq4cmBCs+Bjs3LGFuaSgDFYrwUmriX7rU=;
 b=daab56cpVTFX7lfheqdgIEimJuwlTKXL+9j22X5kM7l24W5099tqoS+rWZOR277UEYz9
 2/VMeq4VBJZbHAD/fXsXjQtTBF4RUII82SHA8lTQc7EPBoGD9dsnd/DJY9tZ0G/BxHh8
 W9H2M63mnfBV2y/X46JbbU/K96Srw2/J2Gnb/LEtiqGgxcdopNarFyU0AeI4e5aMe8BX
 7N8NC64cQC+dXsejfXedteACNop3rGGfTuEOGAH1f1MRNqM03VHo6pBk4MVxK/FTdx4f
 bLXullJSCQh6PpVCMFvA0Aor48TQD/iu+7LC1glGhpq3seHyA+t/eNctGHZk2k8YKAwQ xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 308ffdcrfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 18:28:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037IGeLH159426;
 Tue, 7 Apr 2020 18:28:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073ssp03e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 18:28:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037ISak1005830;
 Tue, 7 Apr 2020 18:28:36 GMT
Received: from [10.175.215.143] (/10.175.215.143)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 07 Apr 2020 11:28:36 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Dan Williams <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
Date: Tue, 7 Apr 2020 19:28:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 5:55 PM, Dan Williams wrote:
> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 4/1/20 4:13 AM, Jingqi Liu wrote:
>>> If the backend file is devdax pmem character device, the alignment
>>> specified by the option 'align=NUM' in the '-object memory-backend-file'
>>> needs to match the alignment requirement of the devdax pmem character device.
>>>
>>> This patch fetches the devdax pmem file 'align', so that we can compare
>>> it with the NUM of 'align=NUM'.
>>> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
>>>
>>> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
>>> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
>>>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>>> ---
>>>  exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 45 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/exec.c b/exec.c
>>> index de9d949902..8221abffec 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>>>      return size;
>>>  }
>>>
>>> +static int64_t get_file_align(int fd)
>>> +{
>>> +    int64_t align = -1;
>>> +#if defined(__linux__)
>>> +    struct stat st;
>>> +
>>> +    if (fstat(fd, &st) < 0) {
>>> +        return -errno;
>>> +    }
>>> +
>>> +    /* Special handling for devdax character devices */
>>> +    if (S_ISCHR(st.st_mode)) {
>>> +        g_autofree char *subsystem_path = NULL;
>>> +        g_autofree char *subsystem = NULL;
>>> +
>>> +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>>> +                                         major(st.st_rdev), minor(st.st_rdev));
>>> +        subsystem = g_file_read_link(subsystem_path, NULL);
>>> +
>>> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
>>> +            g_autofree char *align_path = NULL;
>>> +            g_autofree char *align_str = NULL;
>>> +
>>> +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
>>> +                                    major(st.st_rdev), minor(st.st_rdev));
>>> +
>>
>> Perhaps, you meant instead:
>>
>>         /sys/dev/char/%d:%d/align
>>
> 
> Hmm, are you sure that's working? 

It is, except that I made the slight mistake of testing with a bunch of wip
patches on top which one of them actually adds the 'align' to child dax device.

Argh, my apologies - and thanks for noticing.

> I expect the alignment to be found
> in the region device:
> 
> /sys/class/dax:
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
> $(readlink -f /sys/dev/char/253\:263)/../align
> $(readlink -f /sys/dev/char/253\:263)/device/align
> 
> 
> /sys/bus/dax:
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
> $(readlink -f /sys/dev/char/253\:265)/../align
> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
> 
> The use of the /sys/dev/char/%d:%d/device is only supported by the
> deprecated /sys/class/dax. 

I don't have the deprecated dax class enabled as could you tell, so the second
case is what I was testing. Except it wasn't a namespace/nvdimm but rather an
hmem device-dax.

'../align' though covers only one case? What about hmem which '../align' returns
ENOENT; perhaps using '../dax_region/align' instead which is common to both?
Albeit that wouldn't address the sub-division devices (that I mention above)

> The current /sys/bus/dax device-model can
> be a drop in replacement as long as software is not written to the
> /sys/class sysfs layout, i.e. it uses ../ instead of device/ to walk
> to the region properties.
> 
/nods

