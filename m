Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FD02084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqAe4T3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FD02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnnx-0002AX-3d
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibnnI-0001SL-Hu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibnnG-0000Xa-CI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:39:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibnnG-0000X6-8n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575301161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvkvS0IWcDTCEUIoMudO1um3XDyaaLJSc8nYCHtyccg=;
 b=PqAe4T3Df4L6fjkE5X99mrg+b+GJH7ks2neuTAv7tmjaqkAddAflj2CgijYsXaDRv8oCXg
 OAUyh7+mKBepfrcXp/I27diYeK5nUAQwXKWGVm35XD/MrSe/7ZN/uy4ysEIJhr+K9whTDf
 W5/TuQf/YoPaKIPO6VtPaJ56SOZ18Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-l7wWn-aGMmGfoq2Qy_jMyQ-1; Mon, 02 Dec 2019 10:39:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A87108BC2F;
 Mon,  2 Dec 2019 15:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC6B5D6BB;
 Mon,  2 Dec 2019 15:39:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60B551138606; Mon,  2 Dec 2019 16:39:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: virtiofsd: Where should it live?
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
Date: Mon, 02 Dec 2019 16:39:09 +0100
In-Reply-To: <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com> (Thomas Huth's
 message of "Mon, 2 Dec 2019 14:32:30 +0100")
Message-ID: <877e3eenz6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: l7wWn-aGMmGfoq2Qy_jMyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 mszeredi@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 02/12/2019 13.56, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>>> On Tue, 26 Nov 2019 at 12:15, Dr. David Alan Gilbert
>>> <dgilbert@redhat.com> wrote:
>>>>
>>>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>>>> My main objection to 'contrib/' is actually the perceived notions
>>>>> about what the contrib directory is for. When I see 'contrib/'
>>>>> code in either QEMU, or other open source projects, my general
>>>>> impression is that this is largely unsupported code which is just
>>>>> there as it might be interesting to someone, and doesn't typically
>>>>> get much ongoing dev attention.
>>>
>>>>> virtiofsd is definitely different as it is intended to be a
>>>>> fully production quality supported tool with active dev into
>>>>> the future IIUC.
>>>>>
>>>>> IOW, if we did decide we want it in QEMU, then instead of
>>>>> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
>>>>
>>>> I'm not sure it deserves a new top level for such a specific tool.
>>>
>>> Maybe, but I think I agree with Daniel that 'contrib/' is
>>> probably not the right place for it if it's something that
>>> we care about supporting. 'contrib' to me is "bucket of stuff
>>> that we didn't really feel strongly we wanted to reject but
>>> which is probably random special-cases or other obscure
>>> stuff, don't bother looking in here and don't assume it's
>>> going to work either".
>>=20
>> Agree.
>>=20
>> We have source for several separate programs in the root directory
>> already: qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
>> qemu-keymap, qemu-seccomp, qemu-ga.  Just a .c file when that suffixes,
>> else a subdirectory, except for qemu-io, which is two .c files in the
>> root, plus include/qemu-io.h.  Putting virtiofsd/ there follows
>> qemu-ga's precedence.
>
> IMHO the root directory is still way too overcrowded. Maybe we should
> simply introduce a "tools" subdirectory?

Maybe.  In general, I prefer my source trees shallow.

We've sucked at keeping new files out of the root that don't belong
there.  Mending our ways going forward is just one half of the fix.  The
other half is cleaning up the mess we made.

The manual should be somewhere below docs/.

Several .[ch] should be in a suitable subdirectory.

    $ git-ls-files | grep -v / | grep '\.[ch]$'
    arch_init.c
    balloon.c
    block.c
    blockdev-nbd.c
    blockdev.c
    blockjob.c
    bootdevice.c
    bt-host.c
    bt-vhci.c
    cpus-common.c
    cpus.c
    device-hotplug.c
    device_tree.c
    disas.c
    dma-helpers.c
    exec-vary.c
    exec.c
    gdbstub.c
    ioport.c
    iothread.c
    job-qmp.c
    job.c
    memory.c
    memory_ldst.inc.c
    memory_mapping.c
    module-common.c
    os-posix.c
    os-win32.c
    qdev-monitor.c
    qemu-bridge-helper.c
    qemu-edid.c
    qemu-img.c
    qemu-io-cmds.c
    qemu-io.c
    qemu-keymap.c
    qemu-nbd.c
    qemu-options-wrapper.h
    qemu-options.h
    qemu-seccomp.c
    qtest.c
    replication.c
    replication.h
    thunk.c
    tpm.c
    vl.c


