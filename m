Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE909C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A71820706
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8JBHbmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A71820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4wk-0007s3-DF
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo4w8-0007PP-Jt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:55:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo4w5-0007yr-Lt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593003328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lxrz40v3iMU/gpHSdRUPQOGQyvxEPZKEcn3QfEJYYgM=;
 b=h8JBHbmR9N8fWalnbap8+O4UtuuxhZzF82GMWAaqNyqAUCTBVXsL2lHn2EQZYk4sYHZ1oy
 vBLMOqD4+P5P3dwVAcRBj7UwEHc9EkaV2YiARlWd8ujsmQoQ8emUUP2OeL1uOWExu9b675
 oyv/NgYaqc6OItrZhq/Rbg/FBqRdLrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-3xp6kFdMOb25wJVtErTcSg-1; Wed, 24 Jun 2020 08:55:26 -0400
X-MC-Unique: 3xp6kFdMOb25wJVtErTcSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29BF21B18BC2;
 Wed, 24 Jun 2020 12:55:25 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06CAF8FF60;
 Wed, 24 Jun 2020 12:55:02 +0000 (UTC)
Date: Wed, 24 Jun 2020 14:55:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
Message-ID: <20200624145500.69f9ab24.cohuck@redhat.com>
In-Reply-To: <d627e738-7414-4c7f-52ce-4972dfc30544@redhat.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-7-walling@linux.ibm.com>
 <20200624143635.2d87c1ca.cohuck@redhat.com>
 <d627e738-7414-4c7f-52ce-4972dfc30544@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Collin Walling <walling@linux.ibm.com>, frankja@linux.ibm.com,
 mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 14:40:58 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 24/06/2020 14.36, Cornelia Huck wrote:
> > On Thu, 18 Jun 2020 18:22:56 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> As more features and facilities are added to the Read SCP Info (RSCPI)
> >> response, more space is required to store them. The space used to store
> >> these new features intrudes on the space originally used to store CPU
> >> entries. This means as more features and facilities are added to the
> >> RSCPI response, less space can be used to store CPU entries.
> >>
> >> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
> >> the RSCPI command and determine if the SCCB is large enough to store a
> >> complete reponse. If it is not large enough, then the required length
> >> will be set in the SCCB header.
> >>
> >> The caller of the SCLP command is responsible for creating a
> >> large-enough SCCB to store a complete response. Proper checking should
> >> be in place, and the caller should execute the command once-more with
> >> the large-enough SCCB.
> >>
> >> This facility also enables an extended SCCB for the Read CPU Info
> >> (RCPUI) command.
> >>
> >> When this facility is enabled, the boundary violation response cannot
> >> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
> >>
> >> In order to tolerate kernels that do not yet have full support for this
> >> feature, a "fixed" offset to the start of the CPU Entries within the
> >> Read SCP Info struct is set to allow for the original 248 max entries
> >> when this feature is disabled.
> >>
> >> Additionally, this is introduced as a CPU feature to protect the guest
> >> from migrating to a machine that does not support storing an extended
> >> SCCB. This could otherwise hinder the VM from being able to read all
> >> available CPU entries after migration (such as during re-ipl).
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>   hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
> >>   include/hw/s390x/sclp.h             |  1 +
> >>   target/s390x/cpu_features_def.inc.h |  1 +
> >>   target/s390x/gen-features.c         |  1 +
> >>   target/s390x/kvm.c                  |  8 ++++++++
> >>   5 files changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> >> index 0dfbe6e5ec..f7c49e339e 100644
> >> --- a/hw/s390x/sclp.c
> >> +++ b/hw/s390x/sclp.c
> >> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
> >>       uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> >>   
> >>       switch (code & SCLP_CMD_CODE_MASK) {
> >> +    case SCLP_CMDW_READ_SCP_INFO:
> >> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> >> +    case SCLP_CMDW_READ_CPU_INFO:
> >> +        /*
> >> +         * An extended-length SCCB is only allowed for Read SCP/CPU Info and
> >> +         * is allowed to exceed the 4k boundary. The respective commands will
> >> +         * set the length field to the required length if an insufficient
> >> +         * SCCB length is provided.
> >> +         */
> >> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
> >> +            return true;
> >> +        }  
> > 
> > Add a fallthrough annotation?  
> 
> ... otherwise Coverity and friends will complain later.

Nod.

> 
> >>       default:
> >>           if (sccb_max_addr < sccb_boundary) {
> >>               return true;
> >> @@ -72,6 +84,10 @@ static bool sccb_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
> >>   
> >>       if (be16_to_cpu(sccb->h.length) < required_len) {
> >>           sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> >> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
> >> +            sccb->h.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE) {
> >> +            sccb->h.length = required_len;
> >> +        }
> >>           return false;
> >>       }
> >>       return true;
> >> @@ -101,7 +117,9 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
> >>    */
> >>   static inline int get_read_scp_info_data_len(void)
> >>   {
> >> -    return offsetof(ReadInfo, entries);
> >> +    return s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
> >> +           offsetof(ReadInfo, entries) :
> >> +           SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
> >>   }
> >>   
> >>   /* Provide information about the configuration, CPUs and storage */
> >> @@ -116,6 +134,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
> >>       CPUEntry *entries_start = (void *)sccb + data_len;
> >>   
> >>       if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
> >> +        warn_report("insufficient sccb size to store read scp info response");  
> > 
> > Hm, this warning is triggered by a guest action, isn't it? Not sure how
> > helpful it is.  
> 
> I think this should be qemu_log_mask(LOG_GUEST_ERROR, ...) instead?

Yes, that sounds better.


