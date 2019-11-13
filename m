Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2641222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slg+5aKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2641222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUsYJ-0001fZ-W5
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iUsXY-0001D6-VR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iUsXX-00020d-Qe
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:18:32 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iUsXX-00020G-K5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:18:31 -0500
Received: by mail-wr1-x441.google.com with SMTP id z10so2297081wrs.12
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DNDmsdC8KTivu9P4wXUz57ITW1oSvKv0oO5pwGmCVYE=;
 b=slg+5aKLKMDUWtD0gs7XKzMx43Zg7yS+D1JxSNE6qXCM+1zE4hGGyAb0CoKIlO8uuQ
 y+AmIOLKuvQNnYlAXJLLIuYsG/pmH5zzhY09ADJHPkgFQEuWtuuRjSUS7S66UyU78Vvg
 3qWk1OdbgySTkq9oWdK5+3wiTryd2FVrzrixJIDk5o9O2tLkOg1CnrCiRZRnqJfYVU7Z
 2VY1CVZAF+zdhhHOgYwsxa6H9hEKRA4A22XTLgjE+o3SFpQfFT6IkK6+ntMEwBx7nP9S
 BHgQiNPvt2WqLi84QeCTT8Vy5WyxRLcmAgTHuW1JObp474c63MdmUqN2fyydMRB06ME+
 I0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DNDmsdC8KTivu9P4wXUz57ITW1oSvKv0oO5pwGmCVYE=;
 b=dZSFf3pBMClRP2r5WLl08+pMVJEUzBnoBnBsR1rsB8E1fbnB9h/j+biQjL2qcicuzZ
 VKvkcMLMKhPGBvtqmLMogD46harKJJTMxEJz/YYgmRpVOuERAYtD3E3s1Ou1+0b427Ol
 MTywpa4urrwq4Rf9b4vgTv0NI9gbNIzl44mKAmjkDiOGiMnBDVKDyVZMxgtVTQHMD12u
 SA6iw5Z2aiqm+lEpytZZ6+CEX37HuwFCHYOSz3fvTRvNd+1DehRv69hysTXG8vzQntZF
 WVdVIp7xhQ2dpDuPrPL4wY8Qk6b+gTxDMVvDlDIC4tonmh0b8elo0z5KZoZclOKGF7uG
 BKSQ==
X-Gm-Message-State: APjAAAWUmSDm10xcKCc+cS3DL0AkSH5ri80tGDYDE3fzY99BCaOWRF5G
 JCSShm9yWOxDYSbXpnlPZk3LTyLLgQ/sUNTXWNc=
X-Google-Smtp-Source: APXvYqwT3kRpw9q+xPV8vmvNFtMheE5J0uf1lUzU6lKirTdr/NTGJ1mfecoo80Y8Emvp1fSeBa60wuujjF4HvPZxkaE=
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr2750858wrs.396.1573651110290; 
 Wed, 13 Nov 2019 05:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20191106130309.6737-1-jandryuk@gmail.com>
 <878sok2ble.fsf@dusky.pond.sub.org>
In-Reply-To: <878sok2ble.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Nov 2019 17:18:16 +0400
Message-ID: <CAJ+F1C+cnvqg7P93Fhxn7xreivQFW9eOYDbPa9j83mz7ZR_Wvg@mail.gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: QEMU <qemu-devel@nongnu.org>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 13, 2019 at 4:41 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Jason Andryuk <jandryuk@gmail.com> writes:
>
> > Currently, mon->commands is uninitialized until CHR_EVENT_OPENED where
> > it is set to &qmp_cap_negotiation_commands.  After capability
> > negotiation, it is set to &qmp_commands.  If the chardev is closed,
> > CHR_EVENT_CLOSED, mon->commands remains as &qmp_commands.  Only once th=
e
> > chardev is re-opened with CHR_EVENT_OPENED, is it reset to
> > &qmp_cap_negotiation_commands.
> >
> > monitor_qapi_event_emit compares mon->commands to
> > &qmp_cap_negotiation_commands, and skips sending events when they are
> > equal.
>
> The check's purpose is to ensure we don't send events in capabilities
> negotiation mode, i.e. between connect and a successful qmp_capabilities
> command.
>
> >         In the case of a closed chardev, QMP events are still sent down
> > to the closed chardev which needs to drop them.
>
> True, but I wonder how this can happen.  Can you explain?
>
> > Set mon->commands to &qmp_cap_negotiation_commands for CHR_EVENT_CLOSED
> > to stop sending events.  Setting for the CHR_EVENT_OPENED case remains
> > since that is how mon->commands is set for a newly opened connections.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > ---
> >  monitor/qmp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 9d9e5d8b27..5e2073c5eb 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>        case CHR_EVENT_CLOSED:
>            /*
>             * Note: this is only useful when the output of the chardev
>             * backend is still open.  For example, when the backend is
>             * stdio, it's possible that stdout is still open when stdin
> >           * is closed.
> >           */
> >          monitor_qmp_cleanup_queues(mon);
> > +        mon->commands =3D &qmp_cap_negotiation_commands;
> >          json_message_parser_destroy(&mon->parser);
> >          json_message_parser_init(&mon->parser, handle_qmp_command,
> >                                   mon, NULL);
>
> Patchew reports this loses SHUTDOWN events.  Local testing confirms it
> does.  Simplified reproducer:
>
>     $ for ((i=3D0; i<100; i++)); do printf '{"execute": "qmp_capabilities=
"}\n{"execute": "quit"}' | upstream-qemu -S -display none -qmp stdio; done =
| grep -c SHUTDOWN
>     84
>
> In this test, the SHUTDOWN event was lost 16 out of 100 times.
>
> Its emission obviously races with the assignment you add.
>
> The comment preceding it provides a clue: after CHR_EVENT_CLOSED, we
> know the input direction is gone, and we duly clean up that part of the
> monitor.  But the output direction may or may not be gone, so we don't
> touch it.  Your assignment touches it.  This is not the correct spot.
> I can't tell you offhand where the correct spot is.  Perhaps Marc-Andr=C3=
=A9
> can.

The same "closed" event is used to signal read-disconnected,
write-disconnected and hup.

To implement half-closed signaling, we would need more events/state
(probably change the chardev API to use input and output streams).
Tbh, I am not sure it's really worth at this point, unless we have a
"visible" bug to fix.





--=20
Marc-Andr=C3=A9 Lureau

