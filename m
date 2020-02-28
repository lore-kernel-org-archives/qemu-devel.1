Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D92E246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRdr2HvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D92E246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d0u-0001oA-Ir
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j7czh-0008Ej-7b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j7czf-0000SG-On
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:35:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j7czc-0000QQ-LS; Fri, 28 Feb 2020 05:35:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id m3so2651766wmi.0;
 Fri, 28 Feb 2020 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ghUp1vyXOG4NGhx1HURHUGKmKGGxA08KgIlXrkb2U9U=;
 b=YRdr2HvCyPzRhvZZ3esnQXuOtM4FiQ15/khlFGi1aUfGxXxyoEU7RZ6fraGSBBbpTX
 yyAB2viJL9xHrdy9hh2x0GmSyCeBuU/xMLedJ1WMzrfQHb4HFWVuf625h9dqTHw6Dz13
 Jfu82SMasGRrVAqh1fOH+swy1XIHYIVKlGbLndf5qOk4OxmiqoJ3Zud1YYqbCHT1entU
 29hP+Ung7A46OckEa81q+bHrHv3/+N4NNq0yLDsoER+bsgOIVIDpQoTq3YtOUoAmVDW/
 fUbkCHLfwmEKHIBczWBlEIPZxbF/gYMudAY3t9dk5nWjbmgdgpLYO6du9xfBoeVmnPEe
 /HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ghUp1vyXOG4NGhx1HURHUGKmKGGxA08KgIlXrkb2U9U=;
 b=IsYtHV0UYBBncYufZVLZem+/7IQhXMilO+HyWgm+8PF2A022tpL9WXJZTQKjaJPY5P
 lAXVuNAsKJkXJIUJC6HbSkMywZb2VNZdzYVtxawwAv0V+qG3DSGraUjV8z8BoWU+APHT
 +ozn6Ox+OZIgzfnlZxGhSVoAJwsfcEeV5pS6ELbg8Dthay1pytew+8y0yNHxCjPmMHRq
 RlcIbTlr81kMtCChtNFUbV/V/w3Y7uL+Ih4mZ0D6VXtb0sbvPHKOP/21VV+KOe4GdBrh
 X8+YLSRRBAa64Khq1Jxr/IVUYt9A6ADtilX3LMm5LRTNwJJV0Amxw/ytU8apEw2QoNuT
 SpBA==
X-Gm-Message-State: APjAAAXx/x+2ve2Xbme7mdQ9DjxqROlBfgYFYTelLFN+rBU13DP6w96I
 QNIFgTj6BDgpTWA5YLkvs7EGAleTNGvdYfl5uiU=
X-Google-Smtp-Source: APXvYqzIDj6lykJrx2zul6fgrbI3Hzf4sgO5kqFJhJbFEXQrOVPxxErEjft/67RJ+YJy4VF4fPlLLIIyqtM9RY3VNh4=
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr4309472wmc.4.1582886139297;
 Fri, 28 Feb 2020 02:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20200227190942.8834-1-philmd@redhat.com>
 <20200228094652.GB1657361@redhat.com>
 <CAJ+F1CL-fbX=dXpopMMT1o-WH1JhrqrzpM55J9cGoGDNpDq=AQ@mail.gmail.com>
 <cc93fc81-3e4d-b8d0-afa7-2c35ac502785@redhat.com>
In-Reply-To: <cc93fc81-3e4d-b8d0-afa7-2c35ac502785@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 28 Feb 2020 11:35:27 +0100
Message-ID: <CAJ+F1CLsRTuWjV3mx1i9OdZaj+YYh5CMqHoedUMbakspTT-wcA@mail.gmail.com>
Subject: Re: [PATCH] qom/object: Comment to use g_slist_free on
 object_class_get_list result
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu trival <qemu-trivial@nongnu.org>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Feb 28, 2020 at 11:09 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 2/28/20 11:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Feb 28, 2020 at 10:47 AM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> >>
> >> On Thu, Feb 27, 2020 at 08:09:42PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >>> Document the list returned by object_class_get_list() must be
> >>> released with g_slist_free() to avoid memory leaks.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> ---
> >>>   include/qom/object.h | 6 ++++++
> >>>   1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/include/qom/object.h b/include/qom/object.h
> >>> index 29546496c1..5517b56508 100644
> >>> --- a/include/qom/object.h
> >>> +++ b/include/qom/object.h
> >>> @@ -984,6 +984,9 @@ void object_class_foreach(void (*fn)(ObjectClass =
*klass, void *opaque),
> >>>    * @include_abstract: Whether to include abstract classes.
> >>>    *
> >>>    * Returns: A singly-linked list of the classes in reverse hashtabl=
e order.
> >>> + *
> >>> + * The returned list must be released with g_slist_free()
> >>> + * when no longer required.
> >>
> >> I'd suggest
> >>
> >>    "The returned list, but not its elements, must be released with
> >>     g_slist_free() or g_autoptr when no longer required"
> >
> > As gobject-introspection annotations: "Returns: (transfer container)
> > (element-type ObjectClass): A list of #ObjectClass"
>
> Are you suggesting to replace "Returns: A singly-linked list of the
> classes in reverse hashtable order." by the line you quoted?

No, just a remark. I doubt this is compatible with kernel-doc at this
point, and we are not using GI.

fwiw, I don't think "in reverse hashtable order" is really meaningful anywa=
y.

>
> >
> >>
> >>>    */
> >>>   GSList *object_class_get_list(const char *implements_type,
> >>>                                 bool include_abstract);
> >>> @@ -995,6 +998,9 @@ GSList *object_class_get_list(const char *impleme=
nts_type,
> >>>    *
> >>>    * Returns: A singly-linked list of the classes in alphabetical
> >>>    * case-insensitive order.
> >>> + *
> >>> + * The returned list must be released with g_slist_free()
> >>> + * when no longer required.
> >>>    */
> >>>   GSList *object_class_get_list_sorted(const char *implements_type,
> >>>                                 bool include_abstract);
> >>> --
> >>> 2.21.1
> >>>
> >>>
> >>
> >> Regards,
> >> Daniel
> >> --
> >> |: https://berrange.com      -o-    https://www.flickr.com/photos/dber=
range :|
> >> |: https://libvirt.org         -o-            https://fstop138.berrang=
e.com :|
> >> |: https://entangle-photo.org    -o-    https://www.instagram.com/dber=
range :|
> >>
> >>
> >
> >
>


--=20
Marc-Andr=C3=A9 Lureau

