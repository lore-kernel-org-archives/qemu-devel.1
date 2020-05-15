Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3507C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB2A20728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtCHet6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB2A20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTJc-0005Kj-Df
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTIq-0004sv-DA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:54:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42353
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTIp-0001jw-H1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbfWUGkDWsPus7NalqHrV6a9Hj8qGK/bWiscyFRPauQ=;
 b=EtCHet6BlmlKMsMIbvRdcSUyqWnX2ed7aSlcA4hCJlYFKEzW5ifCpZ11jjpHV5/U2OCmJ0
 Qq/dxqt1nJ+QH1R72NcrvvXg/SKBabFOTrVaMYI2MXm/rKG57D2On6FxQCHLFi3/JysFj8
 jayLzJuqaAPw4IhATHNPsy6cdGJrPvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-wAka8H25OA2aWan4J19i4Q-1; Fri, 15 May 2020 01:54:30 -0400
X-MC-Unique: wAka8H25OA2aWan4J19i4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D85D1005510;
 Fri, 15 May 2020 05:54:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC687D970;
 Fri, 15 May 2020 05:54:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E77B11358BC; Fri, 15 May 2020 07:54:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <1287b3b8-9fd0-04d5-1dd2-66b695dace5d@redhat.com>
Date: Fri, 15 May 2020 07:54:27 +0200
In-Reply-To: <1287b3b8-9fd0-04d5-1dd2-66b695dace5d@redhat.com> (Paolo
 Bonzini's message of "Thu, 14 May 2020 14:37:34 +0200")
Message-ID: <877dxdspyk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/05/20 10:56, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
>>> IMHO configuration files are in general a failed experiment.  In
>>> practice, they do not add much value over just a shell script because
>>> they don't allow configuring all QEMU options, they are very much fixed
>>> (by their nature).  I think it's more or less agreed that they are not
>>> solving any problem for higher-level management stacks as well; those
>>> would prefer to configure the VM via QMP or another API.
>>>
>>> So, any objections to deprecating -readconfig and -writeconfig?
>>=20
>> Libvirt would like to have a config file for QEMU, but it would have
>> to be one that actually covers all the config options QEMU supports,
>> and ideally using a data format in common with that used for runtime
>> changes. So for libvirt's needs the current readconfig is entirely
>> useless.
>
> Yes, this is what I was thinking about.
>
>> For a less general purpose mgmt app, that targets some specific use
>> cases I could imagine people might have used readconfig. [...]
>> If we deprecate them, the only alternative users have right now is
>> to go back to passing CLI args. [...] We'd be deciding to kill the
>> feature with no direct replacement, even though it is potentially
>> useful in some limited scenarios.
>>=20
>> If we have a general strategy to eliminate QemuOpts and move entirely
>> to QAPI based config, then I can see -readcofig/-writeconfig may be
>> creating a burden of back compatibility on maintainers.
>
> I don't see QemuOpts going away anytime soon, but I do see more QMP/QAPI
> and less command line in the future as far as management tools are
> concerned.  QemuOpts and HMP will remain for direct usage, for the
> foreseeable future.

I'd prefer not to have two separate configuration infrastructures.

> So I guess we can keep -readconfig but deprecate, or even remove,
> -writeconfig.

Deprecate both as stable interfaces, remove neither.


