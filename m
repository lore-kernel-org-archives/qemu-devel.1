Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE9C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6EF20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCojKYW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6EF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZCq-0008Ss-RX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iyZCH-0007xC-Lt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iyZCG-0005Kk-6t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:43:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iyZCF-0005Jb-Qi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580726595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G0MrmAiruKjFt5vLzFIt8vi8JLTjhD/YZjyKBVbm4o=;
 b=BCojKYW4Iwqe/3iF6JUatBzZrX64zGGtYTLT+ZXUx5x4x1bwbHhVVlz4wa7eDBFctUQ292
 W5dCtSFbr/eApUCEz8gWV8ccukyipXp1QFu2Ahuh/A+xF7+8g1dnSL93ol60opikyE/Qj8
 HeQujJq+vPMy2f2rEo8Rle3zMoSkXEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-fRkHbrLWOB2KYGitM8hjEw-1; Mon, 03 Feb 2020 05:43:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A162D107ACC7;
 Mon,  3 Feb 2020 10:43:09 +0000 (UTC)
Received: from gondolin (ovpn-117-79.ams2.redhat.com [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4669B89A82;
 Mon,  3 Feb 2020 10:43:08 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:43:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 5/8] vfio-ccw: Add support for the schib region
Message-ID: <20200203114305.7fd301c0.cohuck@redhat.com>
In-Reply-To: <70370f47-b36b-d36a-c8b7-f7cace7f47b4@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-6-farman@linux.ibm.com>
 <20191120121329.73dbddc2.cohuck@redhat.com>
 <70370f47-b36b-d36a-c8b7-f7cace7f47b4@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: fRkHbrLWOB2KYGitM8hjEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Fri, 31 Jan 2020 15:15:00 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> [Had two un-addressed QEMU comments on my todo list; let's do that now.]
> 
> On 11/20/19 6:13 AM, Cornelia Huck wrote:
> > On Fri, 15 Nov 2019 04:34:34 +0100
> > Eric Farman <farman@linux.ibm.com> wrote:

Oh, that was some time ago... hope I can still recall what I was
thinking back then.

> >   
> >> From: Farhan Ali <alifm@linux.ibm.com>
> >>
> >> The schib region can be used to obtain the latest SCHIB from the host
> >> passthrough subchannel. Since the guest SCHIB is virtualized,
> >> we currently only update the path related information so that the
> >> guest is aware of any path related changes when it issues the
> >> 'stsch' instruction.  
> > 
> > One important information here is that you tweak the generic stsch
> > handling, although the behaviour remains the same for non-vfio
> > subchannels.
> >   
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>
> >> Notes:
> >>     v0->v1: [EF]
> >>      - Change various incarnations of "update chp status" to
> >>        "handle_store", to reflect the STSCH instruction that will
> >>        drive this code
> >>      - Remove temporary variable for casting/testing purposes in
> >>        s390_ccw_store(), and add a block comment of WHY its there.
> >>      - Add a few comments to vfio_ccw_handle_store()
> >>
> >>  hw/s390x/css.c              |  8 ++++--
> >>  hw/s390x/s390-ccw.c         | 20 +++++++++++++
> >>  hw/vfio/ccw.c               | 57 +++++++++++++++++++++++++++++++++++++
> >>  include/hw/s390x/css.h      |  3 +-
> >>  include/hw/s390x/s390-ccw.h |  1 +
> >>  target/s390x/ioinst.c       |  3 +-
> >>  6 files changed, 87 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index 844caab408..6ee6a96d75 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -1335,11 +1335,15 @@ static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
> >>      }
> >>  }
> >>  
> >> -int css_do_stsch(SubchDev *sch, SCHIB *schib)
> >> +IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib)
> >>  {
> >> +    int ret = IOINST_CC_EXPECTED;  
> > 
> > It's a bit useless initializing ret here, given that you use it right
> > below :)
> >   
> >> +  
> > 
> > Maybe add a comment here:
> > 
> >        /*
> >         * For some subchannels, we may want to update parts of
> >         * the schib (e.g. update path masks from the host device
> >         * for passthrough subchannels).
> >         */
> >   
> >> +    ret = s390_ccw_store(sch);
> >> +
> >>      /* Use current status. */
> >>      copy_schib_to_guest(schib, &sch->curr_status);
> >> -    return 0;
> >> +    return ret;
> >>  }
> >>  
> >>  static void copy_pmcw_from_guest(PMCW *dest, const PMCW *src)
> >> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> >> index 0c5a5b60bd..be0b379338 100644
> >> --- a/hw/s390x/s390-ccw.c
> >> +++ b/hw/s390x/s390-ccw.c
> >> @@ -51,6 +51,26 @@ int s390_ccw_clear(SubchDev *sch)
> >>      return cdc->handle_clear(sch);
> >>  }
> >>  
> >> +IOInstEnding s390_ccw_store(SubchDev *sch)
> >> +{
> >> +    S390CCWDeviceClass *cdc = NULL;
> >> +    int ret = IOINST_CC_EXPECTED;
> >> +
> >> +    /*
> >> +     * This only applies to passthrough devices, so we can't unconditionally
> >> +     * set this variable like we would for halt/clear.  
> > 
> > Hm, can we maybe handle this differently? We have a generic ccw_cb in
> > the subchannel structure for ccw interpretation; would it make sense to
> > add a generic callback for stsch there as well?  
> 
> Might make things a little cleaner, but I am not sure.  I'm going to
> leave a todo here while we sort out the rest of the kernel code, so I
> can try to put something more beneficial together.

Yes, this looks like something that can be sorted out later.

What bothers me most here, I guess, is that it is not very obvious why
the functions above can assume the presence of the cdc object, while
this one can't. The secret sauce is in the different
do_subchannel_work_* callbacks, which reside in another file... maybe
amend the comment here to mention that? That would help and doesn't
involve code refactoring :)

> 
> > 
> > (This works fine, though. Might want to add the check for halt/clear as
> > well, but that might be a bit overkill.)
> >   
> >> +     */
> >> +    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
> >> +        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
> >> +    }
> >> +
> >> +    if (cdc && cdc->handle_store) {
> >> +        ret = cdc->handle_store(sch);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >>  static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> >>                                    char *sysfsdev,
> >>                                    Error **errp)
> >> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >> index 3e32bc1819..2ff223470f 100644
> >> --- a/hw/vfio/ccw.c
> >> +++ b/hw/vfio/ccw.c
> >> @@ -41,6 +41,9 @@ struct VFIOCCWDevice {
> >>      uint64_t async_cmd_region_size;
> >>      uint64_t async_cmd_region_offset;
> >>      struct ccw_cmd_region *async_cmd_region;
> >> +    uint64_t schib_region_size;
> >> +    uint64_t schib_region_offset;
> >> +    struct ccw_schib_region *schib_region;
> >>      EventNotifier io_notifier;
> >>      bool force_orb_pfch;
> >>      bool warned_orb_pfch;
> >> @@ -124,6 +127,45 @@ again:
> >>      }
> >>  }
> >>  
> >> +static IOInstEnding vfio_ccw_handle_store(SubchDev *sch)
> >> +{
> >> +    S390CCWDevice *cdev = sch->driver_data;
> >> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> >> +    SCHIB *schib = &sch->curr_status;
> >> +    struct ccw_schib_region *region = vcdev->schib_region;
> >> +    SCHIB *s = (SCHIB *)region->schib_area;  
> > 
> > You probably don't want to access region until after you checked it's
> > not NULL :)  
> 
> :)
> 
> >   
> >> +    int ret;
> >> +
> >> +    /* schib region not available so nothing else to do */
> >> +    if (!region) {
> >> +        return IOINST_CC_EXPECTED;
> >> +    }
> >> +
> >> +    memset(region, 0, sizeof(*region));
> >> +    ret = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
> >> +                vcdev->schib_region_offset);
> >> +
> >> +    if (ret == -1) {
> >> +        /* Assume device is damaged, regardless of errno */
> >> +        return IOINST_CC_NOT_OPERATIONAL;  
> > 
> > Not sure that's correct; cc 3 for stsch indicates that there are no
> > more subchannels with higher ids?  
> 
> POPS says cc=3 on stsch if the subchannel is not operational, and it's
> not operational if it's not provided to the channel subsystem.  So,
> basically yes.  I guess his idea was to call out a problem on the kvm
> side, so should we just return CC_EXPECTED here, as if there's no region?

Yes, that looks like the better choice (out of the two possible
condition codes...) And also log a moan somewhere?

> 
> >   
> >> +    }
> >> +
> >> +    /*
> >> +     * Selectively copy path-related bits of the SCHIB,
> >> +     * rather than copying the entire struct.
> >> +     */
> >> +    schib->pmcw.pnom = s->pmcw.pnom;
> >> +    schib->pmcw.lpum = s->pmcw.lpum;
> >> +    schib->pmcw.pam = s->pmcw.pam;
> >> +    schib->pmcw.pom = s->pmcw.pom;
> >> +
> >> +    if (s->scsw.flags & SCSW_FLAGS_MASK_PNO) {
> >> +        schib->scsw.flags |= SCSW_FLAGS_MASK_PNO;
> >> +    }
> >> +
> >> +    return IOINST_CC_EXPECTED;
> >> +}
> >> +  
> > 
> > The rest of the patch looks good to me.
> >   
> 


