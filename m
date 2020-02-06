Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08822C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAA720720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlIIyEdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAA720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoGi-0006iq-Sr
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1izoFn-000625-CO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1izoFk-0002kj-MF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:00:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1izoFk-0002jp-AC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581022799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKX/+/+HxxYqV6WWrevhNixSWrPTRBtEhzMwtMNSgqY=;
 b=BlIIyEdCpjJKQhEvFSBpt/+L1salcuSMQJUIhf8rgNP7bsV7hvHEqiN8tQtigwG59AlXhI
 6tlVVMeTUMhskXzyZkTOeOgdMRAHDWeEpIiZkRX3FNbZim8isWEAQCh5abu7UQOT4rtNtf
 bdiBIb6ABnPRfyMl4giPAL+tiOLowFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-HwzfMRZXN3q2z_aJQj_tGw-1; Thu, 06 Feb 2020 15:59:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF3018B6401;
 Thu,  6 Feb 2020 20:59:53 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 377E260BEC;
 Thu,  6 Feb 2020 20:59:48 +0000 (UTC)
Date: Thu, 6 Feb 2020 15:59:48 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu types
 to use cpu_model
Message-ID: <20200206205948.GD412524@habkost.net>
References: <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
 <20190617170106.48d776ca@redhat.com>
 <0a31228d-4d32-2c54-649b-6aef9953fffc@redhat.com>
 <20190617173343.68e3c9ec@redhat.com>
 <20190617162700.GC19178@habkost.net>
 <20190618133410.18b93bcd@redhat.com>
 <20190618135516.GH19178@habkost.net>
 <20190620110239.6c4c092d@redhat.com>
 <20190620144328.GA1862@habkost.net>
 <87908f05-f14a-c502-db0b-96f849d018d1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87908f05-f14a-c502-db0b-96f849d018d1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HwzfMRZXN3q2z_aJQj_tGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, alistair23@gmail.com, marcel@redhat.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 07:48:21PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 6/20/19 4:43 PM, Eduardo Habkost wrote:
> > On Thu, Jun 20, 2019 at 11:02:39AM +0200, Igor Mammedov wrote:
> > > On Tue, 18 Jun 2019 10:55:16 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >=20
> > > > On Tue, Jun 18, 2019 at 01:34:10PM +0200, Igor Mammedov wrote:
> > > > > On Mon, 17 Jun 2019 13:27:00 -0300
> > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > > > On Mon, Jun 17, 2019 at 05:33:43PM +0200, Igor Mammedov wrote:
> > > > > > > On Mon, 17 Jun 2019 17:15:21 +0200
> > > > > > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> > > > > > [...]
> > > > > > > > Yes. Eduardo and you should write some lines to explain thi=
s, and then
> > > > > > > > we will follow :)
> > > > > > > Unfortunately I don't recall details anymore. One could check=
 out all
> > > > > > > implementations of class_by_name callbacks to find out curren=
t state.
> > > > > >=20
> > > > > > See this message for a summary of existing class_by_name quirks=
:
> > > > > >=20
> > > > > >    https://www.mail-archive.com/qemu-devel@nongnu.org/msg615503=
.html
> > > > > >    Date: Wed, 08 May 2019 10:34:44 +0200
> > > > > >    Message-ID: <877eb173a3.fsf@dusky.pond.sub.org>
> > > > > >    Subject: Re: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_=
by_name() functions
> > > > > >=20
> > > > > > I'm unsure about Igor's suggestion to get rid of CPU model name=
s
> > > > > > and use only QOM type names in external interfaces.  In either
> > > > > > case, we can still simplify the rules rules and reduce the amou=
nt
> > > > > > of arch-specific code.
> > > > > as far as we have cpu_class_by_name, we have to watch over that
> > > > > new patches/targets won't add some custom handling/fallbac/whatno=
t.
> > > >=20
> > > > We can get rid of CPUClass::cpu_class_by_name() without changing
> > > > the external interfaces provided by QEMU.
> > > if you mean QMP, than it is possible to keep model there where
> > > it already exists. Based on experiment [1](x86) I did, it's local to
> > > affected target and doesn't pollute other code.
> >=20
> > I mean both command line and QMP.
> >=20
> > >=20
> > > > I don't have a strong opinion about using only QOM types at -cpu,
> > > > yet.  But first we need to get rid of the arch-specific CPU model
> > > > name exceptions enumerated at the URL above (which would be very
> > > > welcome).
> > > One way to get rid of them is to deprecate them in favor of strict
> > > match (no fallback/substitutions/aliases) to typename and when we
> > > drop it make switch type based naming only.
> >=20
> > This is true, but is it desirable?  Aren't we just moving
> > complexity elsewhere?  Management software would still need to
> > translate CPU models from existing VM configurations to QOM type
> > names.
> >=20
> > >=20
> > > 1) I've just took a quick look at how much of duplicated/confusing
> > > code we could get rid off if we drop cpu_class_by_name/*_cpu_list.
> > > It amounts to >800LOC of trivial removal (not counting ppc/s390
> > > that depend on model naming heavily and in need of some non
> > > trivial refactoring)
> >=20
> > Removing the code might be trivial.  Coordinating with the
> > maintainers of all architectures to confirm this is really
> > something everybody wants is the difficult part.
> >=20
> > If you really want to do it, please make sure all the
> > architecture maintainers (and libvirt developers) are involved in
> > the discussion.
>=20
> From the previous link (summary of existing class_by_name quirks):
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg615737.html
>=20
>   "Deprecating unwanted stuff now is likely to make a
>    later cleanup so much easier."
>=20
> This was 8 months ago :/
>=20
> IIUC we need to restart this topic addressing the libvirt community first=
,
> then see with the QEMU one?

The next step is to deprecate the weird and pointless exceptions
listed at the URL you mentioned.  Not all exceptions will affect libvirt (m=
aybe most won't).

In either case, we can just use qemu-deprecated.texi to
communicate this to libvirt developers.  MAINTAINERS already has
a "R: libvir-list" line for qemu-deprecated.texi.

--=20
Eduardo


