Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F865206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC/DfTHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F865206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSxm-0000Qa-Jh
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtSxB-0008JC-Oq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:34:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtSxA-0001IN-0d
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594287290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95m+vveXFqdFSJz1YEHUha3bRVCC5LtbQKgAMro6tp8=;
 b=UC/DfTHWTnOrodTM84a587zGnaZ+c4w3SHs7CoiRaUZ3mPIJZ+HpfMwbpdE5S+uuV1HUuc
 C9UV0dsVPM1Dx4pxgCzcdCYaT5xP+cVBIAZ94HxY9wW8qkn3iVgDgEtYOtZlGDM9gvM/TL
 D6jV++2eZh0vAalm1Sze7039alf57d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-agGgjExyMRuvHTp8DCC8mA-1; Thu, 09 Jul 2020 05:34:47 -0400
X-MC-Unique: agGgjExyMRuvHTp8DCC8mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302DB108BD09;
 Thu,  9 Jul 2020 09:34:46 +0000 (UTC)
Received: from starship (unknown [10.35.206.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0345D9DD;
 Thu,  9 Jul 2020 09:34:40 +0000 (UTC)
Message-ID: <c413edca1ae1e78a03dad7775d9a955684321ea0.camel@redhat.com>
Subject: Re: [PATCH v2 2/7] Implement drain_call_rcu and use it in
 hmp_device_del
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 09 Jul 2020 12:34:39 +0300
In-Reply-To: <20200527131148.GH29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-3-mlevitsk@redhat.com>
 <20200527131148.GH29137@stefanha-x1.localdomain>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-05-27 at 14:11 +0100, Stefan Hajnoczi wrote:
> On Mon, May 11, 2020 at 07:09:46PM +0300, Maxim Levitsky wrote:
> >  /* The operands of the minus operator must have the same type,
> >   * which must be the one that we specify in the cast.
> > diff --git a/qdev-monitor.c b/qdev-monitor.c
> > index 56cee1483f..70877840a2 100644
> > --- a/qdev-monitor.c
> > +++ b/qdev-monitor.c
> > @@ -812,6 +812,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> >          return;
> >      }
> >      dev = qdev_device_add(opts, &local_err);
> > +    drain_call_rcu();
> 
> Please include comments explaining what each drain waits for. Without
> comments we'll quickly lose track of why drain_call_rcu() calls are
> necessary (similar to documenting memory barrier or refcount inc/dec
> pairing).
> 
> > diff --git a/util/rcu.c b/util/rcu.c
> > index 60a37f72c3..e8b1c4d6c5 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -293,6 +293,39 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
> >      qemu_event_set(&rcu_call_ready_event);
> >  }
> >  
> > +
> > +struct rcu_drain {
> > +    struct rcu_head rcu;
> > +    QemuEvent drain_complete_event;
> > +};
> > +
> > +static void drain_rcu_callback(struct rcu_head *node)
> > +{
> > +    struct rcu_drain *event = (struct rcu_drain *)node;
> > +    qemu_event_set(&event->drain_complete_event);
> 
> A comment would be nice explaining that callbacks are invoked in
> sequence so we're sure that all previously scheduled callbacks have
> completed when drain_rcu_callback() is invoked.
> 
> > +}
> > +
> > +void drain_call_rcu(void)
> 
> Please document that the main loop mutex is dropped if it's held. This
> will prevent surprises and allow callers to think about thread-safety
> across this call.

Done.
> 
> Aside from the comment requests:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


Best regards,
	Maxim levitsky


