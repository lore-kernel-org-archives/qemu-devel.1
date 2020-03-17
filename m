Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EBC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D97C20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxSga1Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D97C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9cz-0001Pu-JC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jE9ZJ-0004Av-Rt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jE9ZI-0006gN-8m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:35:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jE9ZI-0006dO-3R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxKD9un5GnXs8odmr6+QBO/iyarfgXC50bd7KwFlRPI=;
 b=BxSga1Y7rcUVxOJeC9Dj+z566MJR0ntR8GQ2TqA93gLwTvhAaoKQnrLNZXapJIFovh8on+
 i6EY6Ehg82t9W+z/W+kFRbVaNnDm4cH4ZAPgKRhjKZ2tlglwUurM0d87OJb8/QvXEEmS8G
 F22HNlLRRgBpGRrL121naLhwKTJmpPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-do-PTBM-N1ub6ezvVakz_Q-1; Tue, 17 Mar 2020 06:35:26 -0400
X-MC-Unique: do-PTBM-N1ub6ezvVakz_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40EC8100550D;
 Tue, 17 Mar 2020 10:35:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64F3073865;
 Tue, 17 Mar 2020 10:35:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
In-Reply-To: <20200317095222.GB492272@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Tue, 17 Mar 2020 09:52:22 +0000")
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
 <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
 <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
 <20200317095222.GB492272@stefanha-x1.localdomain>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 17 Mar 2020 11:35:14 +0100
Message-ID: <87k13jl15p.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Reply-To: quintela@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Mar 16, 2020 at 01:15:35PM -0500, Eric Blake wrote:
>> On 3/16/20 1:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> > On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
>>=20
>> >=20
>> > >=20
>> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > ---
>> > > =C2=A0 migration/global_state.c | 4 ++--
>> > > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>> > >=20
>> > > diff --git a/migration/global_state.c b/migration/global_state.c
>> > > index 25311479a4..cbe07f21a8 100644
>> > > --- a/migration/global_state.c
>> > > +++ b/migration/global_state.c
>> > > @@ -44,8 +44,8 @@ void global_state_store_running(void)
>> > > =C2=A0 {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *state =3D RunState_str(RU=
N_STATE_RUNNING);
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(strlen(state) < sizeof(global_=
state.runstate));
>> > > -=C2=A0=C2=A0=C2=A0 strncpy((char *)global_state.runstate,
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state,=
 sizeof(global_state.runstate));
>> > > +=C2=A0=C2=A0=C2=A0 pstrcpy((char *)global_state.runstate,
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sizeof(global_state.runstate), state);
>>=20
>> Can we guarantee that the padding bytes have been previously set to 0, o=
r do
>> we need to go the extra mile with a memset() or strpadcpy() to guarantee
>> that we have set the entire buffer?
>
> I don't understand GlobalState:

Welcome to the club O:-)

And I thought that with the reviewed-by I had finished here O:-)

> 1. You ask if runstate[] must be padded with NULs but neither
>    global_state_store() nor register_global_state() do that.  Is it
>    really necessary to pad runstate[]?
>
>    If yes, is it safe for global_state_store() and
>    register_global_state() to not pad runstate[]?

it is an error.  All should be padded.

>    If we decide the pad runstate[] to prevent information leaks to the
>    migration destination then I think it should be done in the pre-save
>    function so that it's guaranteed to happen no matter which of the 3
>    functions that write runstate[] has been called.

Ok.
Taking a look at this.

> 2. There is a GlobalState::size field that is only written and then
>    migrated but never read from what I can tell.  :?

Grrr.  It should be used, but it is not :-(

What we have here:
- A static buffer

    uint8_t runstate[100];

That is partially filled.
size: is the size of that buffer that is filled.

But, as we are using

        VMSTATE_BUFFER(runstate, GlobalState),

We are always sending/receiving the whole buffer.  THat is why we have
trouble with padding.  What should we being doing?

Sending just the size, the filled bytes, and making sure that there is
enough space on destination.

But we aren't donig that.  And at this point, I think that I am only
going to fix the 1st part (always zero pad everything sent).

For fixing the other bit, I need to do an incompatible change.

> Juan: Please clarify the above.  Thanks!

Thanks a lot.

Later, Juan.

PD: Why is it done this way?
    Because at the moment, the problem was that qcow2 (as a system, not
    as a device) didn't have a place where to plug pending requests.  So
    I created this section that always exist, and anything that has not
    a device associated can hang a subsection here.  Once that I created
    it, nobody used it.
    And now, just seing what you are telling, I didn't even used the
    right approach.


