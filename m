Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99136C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4DD216C4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pd+K/X/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4DD216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSIb-0004TX-JN
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1kSSHo-0003tZ-A4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 17:56:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1kSSHk-000403-69
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 17:56:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09DLs7rc122711; Tue, 13 Oct 2020 17:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version :
 content-type : content-transfer-encoding : date : from : to : cc : subject
 : in-reply-to : references : message-id; s=pp1;
 bh=Z/kIB/Yw94VBp1txNduTNXkG6OAP2I7e/3a830UfHVA=;
 b=Pd+K/X/yPYPzYxl9OCc5xVAXcKPN6oOuqpMP7UmBI4yZc5VVp7vrmATMHZRErfMZ83ae
 bydJxRvC23c9HjdjWSDWNwzq3BwOrN7+qeukyohyKIrZ99dHywg/j6mumVKgmxj6IOoR
 DM0ONuOq4bwIjI1fnf9brNX/bLf4/Hk6K4MgGRS264YvrlHFYFGGlpO/WzTelJ1wYisW
 D+fuGmhrIi5wSuOXFIVJi+KZcpaiFlp9trZDOMDgI+lTi3fLFGoGEcruanZhoenYuaMw
 quN2DKp1PPRgLQi5jSIoW9uhGw5b4ph8AhpESPN3ZgejoLOQYEaQL2yW+xIejpuT3Ayd QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 345mjb01ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2020 17:56:39 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09DLtcId125182;
 Tue, 13 Oct 2020 17:56:39 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 345mjb01c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2020 17:56:39 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09DLppub017658;
 Tue, 13 Oct 2020 21:56:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 3434k99tka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2020 21:56:38 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09DLubLf54722854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2020 21:56:37 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72B462805A;
 Tue, 13 Oct 2020 21:56:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD41F28059;
 Tue, 13 Oct 2020 21:56:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2020 21:56:36 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 13 Oct 2020 17:56:36 -0400
From: tobin <tobin@linux.vnet.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
In-Reply-To: <20201012164952.GK39408@redhat.com>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
 <20201012161941.GI6677@work-vm> <20201012164952.GK39408@redhat.com>
Message-ID: <0257b008589db389081b1341b1422f4f@linux.vnet.ibm.com>
X-Sender: tobin@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-13_15:2020-10-13,
 2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 clxscore=1011
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130150
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:56:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-12 12:49, Daniel P. Berrangé wrote:
> On Mon, Oct 12, 2020 at 05:21:15PM +0100, Dr. David Alan Gilbert wrote:
>> * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
>> > AMD SEV allows a guest owner to inject a secret blob
>> > into the memory of a virtual machine. The secret is
>> > encrypted with the SEV Transport Encryption Key and
>> > integrity is guaranteed with the Transport Integrity
>> > Key. Although QEMU faciliates the injection of the
> 
> Trivial typo  s/faciliates/facilitates/
> 
>> > launch secret, it cannot access the secret.
>> >
>> > Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
>> > ---
>> >  include/monitor/monitor.h |  3 ++
>> >  include/sysemu/sev.h      |  2 ++
>> >  monitor/misc.c            |  8 ++---
>> >  qapi/misc-target.json     | 18 +++++++++++
>> >  target/i386/monitor.c     |  9 ++++++
>> >  target/i386/sev-stub.c    |  5 +++
>> >  target/i386/sev.c         | 66 +++++++++++++++++++++++++++++++++++++++
>> >  target/i386/trace-events  |  1 +
>> >  8 files changed, 108 insertions(+), 4 deletions(-)
> 
> 
>> > diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> > index dee3b45930..d145f916b3 100644
>> > --- a/qapi/misc-target.json
>> > +++ b/qapi/misc-target.json
>> > @@ -200,6 +200,24 @@
>> >  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>> >    'if': 'defined(TARGET_I386)' }
>> >
>> > +##
>> > +# @sev-inject-launch-secret:
>> > +#
>> > +# This command injects a secret blob into memory of SEV guest.
>> > +#
>> > +# @packet-header: the launch secret packet header encoded in base64
>> > +#
>> > +# @secret: the launch secret data to be injected encoded in base64
> 
> Just to double check, this "secret" is /not/ in clear text, so there's
> no way either QEMU nor the QMP client can access sensitive info, right 
> ?
> 
You are correct. QEMU would only be able to read the secret in the case
of serious user error.

Thank you for your feedback. I have rebased made the changes. Will send
new version in the morning.

-Tobin

> If 'secret' was clear text, then we would need to pass the data across
> QMP in a different way.
> 
>> > +#
>> > +# @gpa: the guest physical address where secret will be injected.
>> > +#
>> > +# Since: 5.1
> 
> s/5.1/5.2/
> 
>> > +#
>> > +##
>> > +{ 'command': 'sev-inject-launch-secret',
>> > +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
>> > +  'if': 'defined(TARGET_I386)' }
>> > +
>> >  ##
>> >  # @dump-skeys:
>> >  #
>> > diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>> > index 27ebfa3ad2..42bcfe6dc0 100644
>> > --- a/target/i386/monitor.c
>> > +++ b/target/i386/monitor.c
>> > @@ -736,3 +736,12 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
>> >
>> >      return data;
>> >  }
>> > +
>> > +void qmp_sev_inject_launch_secret(const char *packet_hdr,
>> > +                                  const char *secret, uint64_t gpa,
>> > +                                  Error **errp)
>> > +{
>> > +    if (sev_inject_launch_secret(packet_hdr, secret, gpa) != 0) {
>> > +        error_setg(errp, "SEV inject secret failed");
> 
> This generic error message is useless - sev_inject_launch_secret() 
> needs
> to take the 'errp' parameter and report what actually failed.
> 
>> > +    }
>> > +}
>> > diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
>> > index e5ee13309c..fed4588185 100644
>> > --- a/target/i386/sev-stub.c
>> > +++ b/target/i386/sev-stub.c
>> > @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>> >  {
>> >      return NULL;
>> >  }
>> > +int sev_inject_launch_secret(const char *hdr, const char *secret,
>> > +                             uint64_t gpa)
>> > +{
>> > +    return 1;
>> > +}
>> > diff --git a/target/i386/sev.c b/target/i386/sev.c
>> > index d273174ad3..cbeb8f2e02 100644
>> > --- a/target/i386/sev.c
>> > +++ b/target/i386/sev.c
>> > @@ -28,6 +28,8 @@
>> >  #include "sysemu/runstate.h"
>> >  #include "trace.h"
>> >  #include "migration/blocker.h"
>> > +#include "exec/address-spaces.h"
>> > +#include "monitor/monitor.h"
>> >
>> >  #define TYPE_SEV_GUEST "sev-guest"
>> >  #define SEV_GUEST(obj)                                          \
>> > @@ -769,6 +771,70 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>> >      return 0;
>> >  }
>> >
>> > +int sev_inject_launch_secret(const char *packet_hdr,
>> > +                             const char *secret, uint64_t gpa)
>> > +{
>> > +    struct kvm_sev_launch_secret input;
>> > +    guchar *data = NULL, *hdr = NULL;
> 
> If you declare with  'g_autofree' you don't need the manual 'g_free'
> calls later. This in turn means you can get rid of the "goto err"
> jumps and instead directly return.
> 
>> > +    int error, ret = 1;
>> > +    void *hva;
>> > +    gsize hdr_sz = 0, data_sz = 0;
>> > +    Error *local_err = NULL;
> 
> Declare with
> 
>    g_autoptr(Error) local_err = NULL
> 
> to fix the leak David mentions
> 
> 
>> > +    MemoryRegion *mr = NULL;
>> > +
>> > +    /* secret can be inject only in this state */
>> > +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
>> > +        error_report("SEV: Not in correct state. (LSECRET) %x",
>> > +                     sev_guest->state);
>> > +        return 1;
>> > +    }
>> > +
>> > +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
>> > +    if (!hdr || !hdr_sz) {
>> > +        error_report("SEV: Failed to decode sequence header");
>> > +        return 1;
>> > +    }
>> > +
>> > +    data = g_base64_decode(secret, &data_sz);
>> > +    if (!data || !data_sz) {
>> > +        error_report("SEV: Failed to decode data");
>> > +        goto err;
>> > +    }
>> > +
>> > +    hva = gpa2hva(&mr, gpa, data_sz, &local_err);
>> > +    if (!hva) {
>> > +        error_report("SEV: Failed to calculate guest address.");
>> 
>> Note this is leaking local_err; you need to turn that into probably an
>>   error_reportf_err(local_err, "SEV: Failed to calculate guest 
>> address:");
> 
> Actually this method needs to take an "Error **errp" parameter, so that 
> the
> error is propagated back to the QMP command handler, and from there
> back to the client app.
> 
>> Also the '5.1' above needs to change to 5.2.
>> 
>> I think with that it looks OK to me.
> 
>> > +        goto err;
>> > +    }
>> > +
>> > +    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
>> > +    input.hdr_len = hdr_sz;
>> > +
>> > +    input.trans_uaddr = (uint64_t)(unsigned long)data;
>> > +    input.trans_len = data_sz;
>> > +
>> > +    input.guest_uaddr = (uint64_t)(unsigned long)hva;
>> > +    input.guest_len = data_sz;
>> > +
>> > +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
>> > +                                input.trans_uaddr, input.trans_len);
>> > +
>> > +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
>> > +                    &input, &error);
>> > +    if (ret) {
>> > +        error_report("SEV: failed to inject secret ret=%d fw_error=%d '%s'",
>> > +                     ret, error, fw_error_to_str(error));
>> > +        goto err;
>> > +    }
>> > +
>> > +    ret = 0;
>> > +
>> > +err:
>> > +    g_free(data);
>> > +    g_free(hdr);
>> > +    return ret;
>> > +}
> 
> 
> Regards,
> Daniel

