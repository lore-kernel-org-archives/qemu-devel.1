Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C8C56201
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FB622243
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClLn6qal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FB622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIqv-0001Rf-4f
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaIpb-0000NG-Va
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaIpZ-00013u-EN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604496484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLP6E9JPhJOe0OglXVdv0mqiPUjocNnK/hr/aiELJfo=;
 b=ClLn6qal1X6pMKDkeVycM6j4r8J1eIQ8JgBBsM+6DGo2TnNTYKYS7AqTaAMoEROqad6j3a
 K64bkHqSoC9FDM2ZFog58y+0kxAhko38yzuwrTSB1ZrtAv+uezTcUSWWUPIe/F1dZDlpVr
 c+QDmRrw5eFQKTy85Qq664z5hAELB4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-0lGAeBhfMoimJDETeh57Uw-1; Wed, 04 Nov 2020 08:28:02 -0500
X-MC-Unique: 0lGAeBhfMoimJDETeh57Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67A28014C1
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 13:28:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B412B60BFA;
 Wed,  4 Nov 2020 13:28:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5453B1132BD6; Wed,  4 Nov 2020 14:28:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <20201103162551.GQ205187@redhat.com>
 <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com>
 <871rh91q4d.fsf@dusky.pond.sub.org>
 <81b2bc92-2b87-d4ac-4ee2-b93b90a35726@redhat.com>
 <20201104113633.GG565323@redhat.com>
Date: Wed, 04 Nov 2020 14:28:00 +0100
In-Reply-To: <20201104113633.GG565323@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Wed, 4 Nov 2020 11:36:33 +0000")
Message-ID: <87tuu5w8tb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 04, 2020 at 12:31:40PM +0100, Paolo Bonzini wrote:
>> On 04/11/20 09:29, Markus Armbruster wrote:
>> > >   It only hurts in the odd case of a boolean option becoming on/off/=
auto
>> > > or on/off/split.
>> > Another argument for deprecating values other than "on" and "off".
>>=20
>> Unfortunately I'm fairly sure that I've seen yes/no in use.

If it wasn't, we'd remove rather than deprecate :)

>>                                                              I can buy
>> insta-removal (not deprecation) of case-insensitivity.

Since case-insensitivity is undocumented, and we're not aware of actual
use, no objection.

> Seems a couple of example usages are my fault as I documented them :-(
>
> docs/system/vnc-security.rst:     -object tls-creds-x509,id=3Dtls0,dir=3D=
/etc/pki/qemu,endpoint=3Dserver,verify-peer=3Dyes \
> docs/system/vnc-security.rst:     -object tls-creds-x509,id=3Dtls0,dir=3D=
/etc/pki/qemu,endpoint=3Dserver,verify-peer=3Dyes \
> docs/system/vnc-security.rst:     -object tls-creds-x509,id=3Dtls0,dir=3D=
/etc/pki/qemu,endpoint=3Dserver,verify-peer=3Dyes \
> include/authz/listfile.h: *           filename=3D/etc/qemu/myvm-vnc.acl,r=
efresh=3Dyes
> qemu-options.hx:    ``-object authz-listfile,id=3Did,filename=3Dpath,refr=
esh=3Dyes|no``
> qemu-options.hx:                 -object authz-simple,id=3Dauth0,filename=
=3D/etc/qemu/vnc-sasl.acl,refresh=3Dyes \\
>
> We should fix thos docs in QEMU at least, and unfortunately it seems I
> missed that libvirt did use  verify-peer=3Dyes

Yes, please.


