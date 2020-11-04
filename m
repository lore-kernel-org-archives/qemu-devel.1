Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123FD20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU7LDV6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123FD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJ5Y-00025W-2p
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaJ4K-00016N-Gv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaJ4I-0003HD-M3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604497397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6H+TQmlrvZ9hkfsf8+S2QHLUuZjqueqcrIobxNtkOeA=;
 b=PU7LDV6xoFQqqQoU8kJhdsh1D2U/W2V+6PGhN99KCI17KMbIstr842ltbSqOZrAmnLytbN
 Qe5VfFVR38iN/XG80lsnVU3U1cnftq8iE1HPRFxzmPnThw6MBmFwZip0+urJSzi9UHqA89
 cnPlwLm5AGpsBr9AiJ2n2JLBeyWsk58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-qxXSEFHHP2KHDNTe4qeU_w-1; Wed, 04 Nov 2020 08:43:16 -0500
X-MC-Unique: qxXSEFHHP2KHDNTe4qeU_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C0468049E8
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 13:43:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE7F5C3E1;
 Wed,  4 Nov 2020 13:43:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EEC41132BD6; Wed,  4 Nov 2020 14:43:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
 <20201103160843.GP205187@redhat.com>
 <ff8ddc26-5d3d-8f0e-47ce-0c721fbef7f1@redhat.com>
Date: Wed, 04 Nov 2020 14:43:13 +0100
In-Reply-To: <ff8ddc26-5d3d-8f0e-47ce-0c721fbef7f1@redhat.com> (Paolo
 Bonzini's message of "Tue, 3 Nov 2020 17:18:41 +0100")
Message-ID: <87imalw83y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/11/20 17:08, Daniel P. Berrang=C3=A9 wrote:
>>> +Short-form boolean options (since 5.2)
>>> +''''''''''''''''''''''''''''''''''''''
>>> +
>>> +Boolean options such as ``share=3Don``/``share=3Doff`` can be written
>>> +in short form as ``share`` and ``noshare``.  This is deprecated
>>> +for all command-line options except ``-chardev` and ``-spice``, for
>>> +which the short form was in wide use.
>>=20
>> So IIUC, the short form was possible to use for absolutely /any/
>> boolean property ?
>
> s/boolean// (yikes)

Yup.  "-device virtio-blk,drive=3Dblk0,serial" gives you the lovely serial
number "on".

>> IMHO if we're going to deprecate short forms, we should do it
>> universally including chardev and spice. Arguably spice/chardev
>> are the most important ones to give an explicit warning about
>> precisely because their widespread usage means a heads up is
>> important to users.
>
> Chardevs will probably become user-creatable objects; for -spice I was
> hoping that it would be QAPIfied as "-display spice" which does not
> support short forms, but I'm not sure if Gerd agrees.  In both cases,
> the problem would be taken care of in a different way.

Taken care of only if we deprecate -chardev and -spice wholesale, not if
we keep them forever as sugar for -object.

> I can certainly warn for all of them, but I was thinking of the
> lowest-impact option for 5.2 since we're already in soft freeze.

I'm quite interested in getting rid of this sugar.  I'm not particular
on how exactly, and I understand your reluctance to mess with 5.2.


