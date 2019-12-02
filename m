Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2190C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8772084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGmNYcHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8772084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibo4B-00039d-Sk
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ibo3P-0002OQ-CF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ibo3N-0007C6-TR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:56:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ibo3N-0007Br-M7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575302161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7E7+AO1dFRXdGvxcu+5fQ6pNS2Hd/usDUqUKekq9riw=;
 b=aGmNYcHmn3BgE+bbAxYnd0wv8fRCLa10GYzure7KNciwVvMok9avooZwy6g+LobM4ghpFW
 VFxh49H7OsplVVLKXhqVxqiRffQbJnLvExLyV6fYZy/Na2dvcMCw1iAYhg+qqWn+XvBLKH
 7Ypoe8lUB/WCqCVDG8m7t8q5uioSHrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-65-gu191OeaMN3c7cGw-pQ-1; Mon, 02 Dec 2019 10:55:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 149851921FBC;
 Mon,  2 Dec 2019 15:55:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A2F1001281;
 Mon,  2 Dec 2019 15:55:57 +0000 (UTC)
Date: Mon, 2 Dec 2019 15:55:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191202155554.GC2904@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <877e3eenz6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877e3eenz6.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 65-gu191OeaMN3c7cGw-pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 mszeredi@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 02/12/2019 13.56, Markus Armbruster wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>=20
> >>> On Tue, 26 Nov 2019 at 12:15, Dr. David Alan Gilbert
> >>> <dgilbert@redhat.com> wrote:
> >>>>
> >>>> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >>>>> My main objection to 'contrib/' is actually the perceived notions
> >>>>> about what the contrib directory is for. When I see 'contrib/'
> >>>>> code in either QEMU, or other open source projects, my general
> >>>>> impression is that this is largely unsupported code which is just
> >>>>> there as it might be interesting to someone, and doesn't typically
> >>>>> get much ongoing dev attention.
> >>>
> >>>>> virtiofsd is definitely different as it is intended to be a
> >>>>> fully production quality supported tool with active dev into
> >>>>> the future IIUC.
> >>>>>
> >>>>> IOW, if we did decide we want it in QEMU, then instead of
> >>>>> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
> >>>>
> >>>> I'm not sure it deserves a new top level for such a specific tool.
> >>>
> >>> Maybe, but I think I agree with Daniel that 'contrib/' is
> >>> probably not the right place for it if it's something that
> >>> we care about supporting. 'contrib' to me is "bucket of stuff
> >>> that we didn't really feel strongly we wanted to reject but
> >>> which is probably random special-cases or other obscure
> >>> stuff, don't bother looking in here and don't assume it's
> >>> going to work either".
> >>=20
> >> Agree.
> >>=20
> >> We have source for several separate programs in the root directory
> >> already: qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> >> qemu-keymap, qemu-seccomp, qemu-ga.  Just a .c file when that suffixes=
,
> >> else a subdirectory, except for qemu-io, which is two .c files in the
> >> root, plus include/qemu-io.h.  Putting virtiofsd/ there follows
> >> qemu-ga's precedence.
> >
> > IMHO the root directory is still way too overcrowded. Maybe we should
> > simply introduce a "tools" subdirectory?
>=20
> Maybe.  In general, I prefer my source trees shallow.

I think I agree with Thomas that it should be in a subdirectory for all
tools like that; creating virtiofsd at the top level feels wrong to me
since it's just too specific.  Someone please pick a name :-)

> We've sucked at keeping new files out of the root that don't belong
> there.  Mending our ways going forward is just one half of the fix.  The
> other half is cleaning up the mess we made.

It's been getting better over time mostly.
We could lose qemu-bridge-helper.c into this new directory.

Dave

> The manual should be somewhere below docs/.
>=20
> Several .[ch] should be in a suitable subdirectory.
>=20
>     $ git-ls-files | grep -v / | grep '\.[ch]$'
>     arch_init.c
>     balloon.c
>     block.c
>     blockdev-nbd.c
>     blockdev.c
>     blockjob.c
>     bootdevice.c
>     bt-host.c
>     bt-vhci.c
>     cpus-common.c
>     cpus.c
>     device-hotplug.c
>     device_tree.c
>     disas.c
>     dma-helpers.c
>     exec-vary.c
>     exec.c
>     gdbstub.c
>     ioport.c
>     iothread.c
>     job-qmp.c
>     job.c
>     memory.c
>     memory_ldst.inc.c
>     memory_mapping.c
>     module-common.c
>     os-posix.c
>     os-win32.c
>     qdev-monitor.c
>     qemu-bridge-helper.c
>     qemu-edid.c
>     qemu-img.c
>     qemu-io-cmds.c
>     qemu-io.c
>     qemu-keymap.c
>     qemu-nbd.c
>     qemu-options-wrapper.h
>     qemu-options.h
>     qemu-seccomp.c
>     qtest.c
>     replication.c
>     replication.h
>     thunk.c
>     tpm.c
>     vl.c
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


