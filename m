Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B048C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0106F20874
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeuOYliZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0106F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfwv-0004MR-8U
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqfvd-0003KV-UE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:49:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jqfvc-0004xb-Cv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593622183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UocrftU7n/ydvGPG95SgKJRD1AGWQ7R4RCj5+NpB0pE=;
 b=eeuOYliZfOidt+cYcWeV1dnePCn831JZFpQxb782KahOhhqQFOzzwi1scilUrKHTPcm143
 Aj15/PmRLZA58dnpiDxtS3q8O1tv8/OtSd+grfD0d+C/K9gsqpLpBr5FlxERuasVLQ4D3Z
 F7LIZf0Pcg+Esq8wVNFyIkg2EN1GZAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-TwY4-78pPj-qPUeIwKj2MQ-1; Wed, 01 Jul 2020 12:49:41 -0400
X-MC-Unique: TwY4-78pPj-qPUeIwKj2MQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC7D118FF661
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 16:49:40 +0000 (UTC)
Received: from work-vm (ovpn-114-200.ams2.redhat.com [10.36.114.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D12C71662;
 Wed,  1 Jul 2020 16:49:40 +0000 (UTC)
Date: Wed, 1 Jul 2020 17:49:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: add support for AMD nested live migration
Message-ID: <20200701164937.GH3608@work-vm>
References: <20200624160608.383931-1-pbonzini@redhat.com>
 <20200701162841.GG3608@work-vm>
 <CABgObfZjrBe+87Lhyw_Zyyuyun3VBpHa1RuzovmvthrU-Ea-pQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfZjrBe+87Lhyw_Zyyuyun3VBpHa1RuzovmvthrU-Ea-pQ@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Il mer 1 lug 2020, 18:28 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
> scritto:
> 
> >
> > > +    return (nested_state->format == KVM_STATE_NESTED_FORMAT_SVM &&
> > > +            nested_state->size > offsetof(struct kvm_nested_state,
> > data));
> >
> > How does this nested_state->size work? It looks like even if it's 1 byte
> > into 'data' we transmit a whole KVM_STATE_NESTED_SVM_VMCB_SIZE.
> >
> 
> The format is documented as having either 0 or KVM_STATE_NESTED_SVM_VMCB_SIZE
> bytes (for vmx instead it can be 0, 4K or 8K).

OK.

Dave

> Paolo
> 
> 
> > Dave
> >
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_svm_nested_state = {
> > > +    .name = "cpu/kvm_nested_state/svm",
> > > +    .version_id = 1,
> > > +    .minimum_version_id = 1,
> > > +    .needed = svm_nested_state_needed,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_U64(hdr.svm.vmcb_pa, struct kvm_nested_state),
> > > +        VMSTATE_UINT8_ARRAY(data.svm[0].vmcb12,
> > > +                            struct kvm_nested_state,
> > > +                            KVM_STATE_NESTED_SVM_VMCB_SIZE),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > >  static bool nested_state_needed(void *opaque)
> > >  {
> > >      X86CPU *cpu = opaque;
> > >      CPUX86State *env = &cpu->env;
> > >
> > >      return (env->nested_state &&
> > > -            vmx_nested_state_needed(env->nested_state));
> > > +            (vmx_nested_state_needed(env->nested_state) ||
> > > +             svm_nested_state_needed(env->nested_state)));
> > >  }
> > >
> > >  static int nested_state_post_load(void *opaque, int version_id)
> > > @@ -1139,6 +1166,7 @@ static const VMStateDescription
> > vmstate_kvm_nested_state = {
> > >      },
> > >      .subsections = (const VMStateDescription*[]) {
> > >          &vmstate_vmx_nested_state,
> > > +        &vmstate_svm_nested_state,
> > >          NULL
> > >      }
> > >  };
> > > --
> > > 2.26.2
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


