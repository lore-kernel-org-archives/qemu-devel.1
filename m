Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B2C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD97020878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF85xWHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD97020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbP3-0004dk-KR
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kSbLx-00029q-2c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kSbLs-0007Cr-BZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602661053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZ0W+f6KFy6m6bY9ZjShHhWsdwzCdSlJPxuFDFuKocU=;
 b=fF85xWHC3oURiTXn/FqDpmqDLBYvZ+iPlDeC7qun6cO9bafJhE9VUmWUOdueVifhu83bui
 oi/8i9aCitkJBgJl9ZnF//l1XVJ4nqC91CH14dov3Ber9F3A85yW9q+zQlycjOr9Zq79/z
 YL1tNmsJD6csQVTNmRRzvL4TYR2j9cQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-zCZGkKPjPpKMEhq5D2AQEw-1; Wed, 14 Oct 2020 03:37:31 -0400
X-MC-Unique: zCZGkKPjPpKMEhq5D2AQEw-1
Received: by mail-io1-f72.google.com with SMTP id t187so1790678iof.22
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iZ0W+f6KFy6m6bY9ZjShHhWsdwzCdSlJPxuFDFuKocU=;
 b=m9OSdSjyJRbqC81Xr9QhKxuY9WF2t6QuPEAMrOetAjXjihga05gEZp9c8H9NVGsyrt
 ZtV0dfC2E9o5t9uHAjeGsagdTwbWHZX9ugkndpFcpeREj84xOdJG2+6i7fHe7/iIJrfP
 sWPilcyYcIN98/L8jb4Ckqtoc5wIFDDo7pGHUWayJJpeHTKVHKdPYZxvviqokdKy0gY/
 2BaNJUoFkIVYZOl3LOKNfa0YK2sAopYc3nlYDtBlFE7ebvc8sXdW4rCN3wchMZhTeSeX
 x5VQymNBMXCPwCAL2apBBxNIeLIp15dCOB16JkPZiL0H8oRGPQY8yJmMlcAo7j2W27a/
 AiSQ==
X-Gm-Message-State: AOAM532zl8aZ5JMDkdjGrZ9ecCYXUyEAs3PQpcOevNrFCa4FtHl6Zr6i
 wkLY/VGk6nzZiKl16WSvymQVJn7I2IU/oMvXd+bEnm26B+RTUlgtNlMhfrFnHb2+7IE4fSCC36v
 BuCIgrvNUb8zBVOA8gTv4KIt5hieeVoQ=
X-Received: by 2002:a92:ba1c:: with SMTP id o28mr2724026ili.182.1602661050288; 
 Wed, 14 Oct 2020 00:37:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfPD97gUMwkpampLtmTzkMRK8jlNeZ7l9+qg8oWCO4WHoBCA/+GC7zW02Hflc3Ywm6DQ5J522ut5vDcfk/zU0=
X-Received: by 2002:a92:ba1c:: with SMTP id o28mr2724016ili.182.1602661049979; 
 Wed, 14 Oct 2020 00:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
 <20201013202502.335336-3-marcandre.lureau@redhat.com>
 <af872421-2215-72e5-77a2-7d496325c413@redhat.com>
In-Reply-To: <af872421-2215-72e5-77a2-7d496325c413@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Oct 2020 11:37:19 +0400
Message-ID: <CAMxuvazo_3pJzwCRkwjaLro2h=SR8xzJ3XFfDcFx_xtDfGOAtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga: add ssh-{add,remove}-authorized-keys
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Oct 14, 2020 at 1:14 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On 10/13/20 10:25 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add new commands to add and remove SSH public keys from
> > ~/.ssh/authorized_keys.
> >
> > I took a different approach for testing, including the unit tests right
> > with the code. I wanted to overwrite the function to get the user
> > details, I couldn't easily do that over QMP. Furthermore, I prefer
> > having unit tests very close to the code, and unit files that are domai=
n
> > specific (commands-posix is too crowded already). Fwiw, that
>
> FWIW

ok

>
> > coding/testing style is Rust-style (where tests can or should even be
> > part of the documentation!).
> >
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1885332
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> ...
>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index cec98c7e06..50e2854b45 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1306,3 +1306,35 @@
> >   ##
> >   { 'command': 'guest-get-devices',
> >     'returns': ['GuestDeviceInfo'] }
> > +
> > +##
> > +# @guest-ssh-add-authorized-keys:
> > +#
> > +# @username: the user account to add the authorized key
> > +# @keys: the public keys to add (in OpenSSH format)
>
> You use plural but the code only seems to add (remove) one key
> at a time.

Uh, what makes you believe that?

>
> 'OpenSSH format' is confusing. From sshd(8):
>
>    Each line of the file contains one key (empty lines and lines
>    starting with a =E2=80=98#=E2=80=99 are ignored as comments).
>
>    Public keys consist of the following space-separated fields:
>
>      options, keytype, base64-encoded key, comment.
>
>    The options field is optional.
>
>    Note that lines in this file can be several hundred bytes long
>    (because of the size of the public key encoding) up to a limit
>    of 8 kilobytes, which permits RSA keys up to 16 kilobits.
>
>    The options (if present) consist of comma-separated option
>    specifications.  No spaces are permitted, except within double
>    quotes.
>
> @openssh_authorized_key_line is ugly, maybe use @authorized_key
> to make it clearer?

Why? the name of the function already implies we are talking about
authorized keys. The documentation says it's a public key in openssh
format (the ones you expect in ~/.ssh/authorized_keys files)

Yes the format isn't very well defined, so I did simple sanity checks.
After all, people usually append keys with shell >>. I can't find a
common command to do it with some checking.

> > +#
> > +# Append a public key to user $HOME/.ssh/authorized_keys on Unix syste=
ms (not
> > +# implemented for other systems).
>
> Here "a key" singular, good.

bad. it should be plural (everywhere else is plural, afaict)

>
> > +#
> > +# Returns: Nothing on success.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-ssh-add-authorized-keys',
>
> Here "keys" plural :/
>
> > +  'data': { 'username': 'str', 'keys': ['str'] } }
> > +
> > +##
> > +# @guest-ssh-remove-authorized-keys:
> > +#
> > +# @username: the user account to add the authorized key
> > +# @keys: the public keys to remove (in OpenSSH format)
> > +#
> > +# Remove public keys from the user $HOME/.ssh/authorized_keys on Unix =
systems
> > +# (not implemented for other systems).
> > +#
> > +# Returns: Nothing on success.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'guest-ssh-remove-authorized-keys',
> > +  'data': { 'username': 'str', 'keys': ['str'] } }
> >
>


