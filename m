Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E389C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFA420CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFA420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixd8c-0006Iu-8H
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 15:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1ixd83-0005tH-AX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1ixd81-0002qu-Ti
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:43:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36314
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1ixd7w-0002gA-Gr; Fri, 31 Jan 2020 15:42:56 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00VKckCT147138; Fri, 31 Jan 2020 15:42:55 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xvtxwrttp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2020 15:42:55 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00VKctZO000974;
 Fri, 31 Jan 2020 15:42:54 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xvtxwrts8-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2020 15:42:54 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00VKC2vQ025723;
 Fri, 31 Jan 2020 20:15:03 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 2xrda7w158-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2020 20:15:03 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00VKF3Lv45547790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2020 20:15:03 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554F8AC060;
 Fri, 31 Jan 2020 20:15:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF68FAC05E;
 Fri, 31 Jan 2020 20:15:00 +0000 (GMT)
Received: from [9.160.119.184] (unknown [9.160.119.184])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 31 Jan 2020 20:15:00 +0000 (GMT)
Subject: Re: [RFC PATCH v1 5/8] vfio-ccw: Add support for the schib region
To: Cornelia Huck <cohuck@redhat.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-6-farman@linux.ibm.com>
 <20191120121329.73dbddc2.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <70370f47-b36b-d36a-c8b7-f7cace7f47b4@linux.ibm.com>
Date: Fri, 31 Jan 2020 15:15:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191120121329.73dbddc2.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-31_06:2020-01-31,
 2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Had two un-addressed QEMU comments on my todo list; let's do that now.]

On 11/20/19 6:13 AM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 04:34:34 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> The schib region can be used to obtain the latest SCHIB from the host
>> passthrough subchannel. Since the guest SCHIB is virtualized,
>> we currently only update the path related information so that the
>> guest is aware of any path related changes when it issues the
>> 'stsch' instruction.
> 
> One important information here is that you tweak the generic stsch
> handling, although the behaviour remains the same for non-vfio
> subchannels.
> 
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v0->v1: [EF]
>>      - Change various incarnations of "update chp status" to
>>        "handle_store", to reflect the STSCH instruction that will
>>        drive this code
>>      - Remove temporary variable for casting/testing purposes in
>>        s390_ccw_store(), and add a block comment of WHY its there.
>>      - Add a few comments to vfio_ccw_handle_store()
>>
>>  hw/s390x/css.c              |  8 ++++--
>>  hw/s390x/s390-ccw.c         | 20 +++++++++++++
>>  hw/vfio/ccw.c               | 57 +++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/css.h      |  3 +-
>>  include/hw/s390x/s390-ccw.h |  1 +
>>  target/s390x/ioinst.c       |  3 +-
>>  6 files changed, 87 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 844caab408..6ee6a96d75 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1335,11 +1335,15 @@ static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
>>      }
>>  }
>>  
>> -int css_do_stsch(SubchDev *sch, SCHIB *schib)
>> +IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib)
>>  {
>> +    int ret = IOINST_CC_EXPECTED;
> 
> It's a bit useless initializing ret here, given that you use it right
> below :)
> 
>> +
> 
> Maybe add a comment here:
> 
>        /*
>         * For some subchannels, we may want to update parts of
>         * the schib (e.g. update path masks from the host device
>         * for passthrough subchannels).
>         */
> 
>> +    ret = s390_ccw_store(sch);
>> +
>>      /* Use current status. */
>>      copy_schib_to_guest(schib, &sch->curr_status);
>> -    return 0;
>> +    return ret;
>>  }
>>  
>>  static void copy_pmcw_from_guest(PMCW *dest, const PMCW *src)
>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>> index 0c5a5b60bd..be0b379338 100644
>> --- a/hw/s390x/s390-ccw.c
>> +++ b/hw/s390x/s390-ccw.c
>> @@ -51,6 +51,26 @@ int s390_ccw_clear(SubchDev *sch)
>>      return cdc->handle_clear(sch);
>>  }
>>  
>> +IOInstEnding s390_ccw_store(SubchDev *sch)
>> +{
>> +    S390CCWDeviceClass *cdc = NULL;
>> +    int ret = IOINST_CC_EXPECTED;
>> +
>> +    /*
>> +     * This only applies to passthrough devices, so we can't unconditionally
>> +     * set this variable like we would for halt/clear.
> 
> Hm, can we maybe handle this differently? We have a generic ccw_cb in
> the subchannel structure for ccw interpretation; would it make sense to
> add a generic callback for stsch there as well?

Might make things a little cleaner, but I am not sure.  I'm going to
leave a todo here while we sort out the rest of the kernel code, so I
can try to put something more beneficial together.

> 
> (This works fine, though. Might want to add the check for halt/clear as
> well, but that might be a bit overkill.)
> 
>> +     */
>> +    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
>> +        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
>> +    }
>> +
>> +    if (cdc && cdc->handle_store) {
>> +        ret = cdc->handle_store(sch);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>  static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>>                                    char *sysfsdev,
>>                                    Error **errp)
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 3e32bc1819..2ff223470f 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -41,6 +41,9 @@ struct VFIOCCWDevice {
>>      uint64_t async_cmd_region_size;
>>      uint64_t async_cmd_region_offset;
>>      struct ccw_cmd_region *async_cmd_region;
>> +    uint64_t schib_region_size;
>> +    uint64_t schib_region_offset;
>> +    struct ccw_schib_region *schib_region;
>>      EventNotifier io_notifier;
>>      bool force_orb_pfch;
>>      bool warned_orb_pfch;
>> @@ -124,6 +127,45 @@ again:
>>      }
>>  }
>>  
>> +static IOInstEnding vfio_ccw_handle_store(SubchDev *sch)
>> +{
>> +    S390CCWDevice *cdev = sch->driver_data;
>> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>> +    SCHIB *schib = &sch->curr_status;
>> +    struct ccw_schib_region *region = vcdev->schib_region;
>> +    SCHIB *s = (SCHIB *)region->schib_area;
> 
> You probably don't want to access region until after you checked it's
> not NULL :)

:)

> 
>> +    int ret;
>> +
>> +    /* schib region not available so nothing else to do */
>> +    if (!region) {
>> +        return IOINST_CC_EXPECTED;
>> +    }
>> +
>> +    memset(region, 0, sizeof(*region));
>> +    ret = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
>> +                vcdev->schib_region_offset);
>> +
>> +    if (ret == -1) {
>> +        /* Assume device is damaged, regardless of errno */
>> +        return IOINST_CC_NOT_OPERATIONAL;
> 
> Not sure that's correct; cc 3 for stsch indicates that there are no
> more subchannels with higher ids?

POPS says cc=3 on stsch if the subchannel is not operational, and it's
not operational if it's not provided to the channel subsystem.  So,
basically yes.  I guess his idea was to call out a problem on the kvm
side, so should we just return CC_EXPECTED here, as if there's no region?

> 
>> +    }
>> +
>> +    /*
>> +     * Selectively copy path-related bits of the SCHIB,
>> +     * rather than copying the entire struct.
>> +     */
>> +    schib->pmcw.pnom = s->pmcw.pnom;
>> +    schib->pmcw.lpum = s->pmcw.lpum;
>> +    schib->pmcw.pam = s->pmcw.pam;
>> +    schib->pmcw.pom = s->pmcw.pom;
>> +
>> +    if (s->scsw.flags & SCSW_FLAGS_MASK_PNO) {
>> +        schib->scsw.flags |= SCSW_FLAGS_MASK_PNO;
>> +    }
>> +
>> +    return IOINST_CC_EXPECTED;
>> +}
>> +
> 
> The rest of the patch looks good to me.
> 

