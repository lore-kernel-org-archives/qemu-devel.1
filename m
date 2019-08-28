Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C433DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9553122CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVn4j0dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9553122CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zfa-0006Yv-G9
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zeA-0005Sz-HH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2ze8-0003Tt-Vh
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:14:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2ze8-0003SL-Kn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:14:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so177316wrd.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=irKt9bgIbhHEi1GnXomYkdfmexFoZng0DFukXOsc5bU=;
 b=GVn4j0dJMtemyfcRDkoy2YpuxeEgQ/8AJ0QNfH2o3aBYkrWxqtTlyu56SJmYlFUrqL
 D136fi3BqGrVC1CL4cCtZ69XENBRUQEw8KofrzXs+jIAYshjuKpxlQOUwnxpHmZK2jbi
 /HQI0pC/5sUgzRYG0l8w2qEvapReSHuPg1FjeWEZpwl7oenMujFwA2y7UxgrINP7a7Or
 cPciqrV+rCbwX2GYEPIB265NxicGwS8ZeEjRaNIGih3HAVUhzkOb1AJOyreIKOWKYXyy
 9M+feoFs+aM1AxnyBnsl6g5ETi0p56t8mxxed4hRqoXWT9XcHIVO8EV/hrhLZM0iVKd3
 7yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=irKt9bgIbhHEi1GnXomYkdfmexFoZng0DFukXOsc5bU=;
 b=p0yObDHFnSTk2WhqhIq8PQs+kdKxExyoxMxDs7aWbjBef3us0rcvwFJSJwMzyGv9R4
 L7d+i3xpthunvpFOJiNQns6u2tfRXXQ8x5aiWyi+tp0bSnih7lfPZ5ZfF0WVbx0xAeQx
 SQ6MYlkSTNrGtfxM3o5hVFwLbNx1tEK1jJy/+u1RnOhEQ/8UCiIS6qFXs4Pq1xIPFvCw
 uLGUouN1Z2pEZVC490RQmIf8jMEGN2YN8/Wil2XWx52eTwQVc7XUuvmWkKUL3jlSFxft
 ds9c2Tulyfx+iaWTCDHrFaWD5Hb5nNbgdObV8PIuylajqZFjw1AKel+ORHKQAn1a+1ss
 4KfQ==
X-Gm-Message-State: APjAAAUloforVwqn/lCUH7W6cylEhrC/8RNg7n/TKTat5gKTNhslkkx/
 ZHHk+S6PO4GZc0s/swEVQmADiPszIxA=
X-Google-Smtp-Source: APXvYqzHxs1ATWgHsK9bnP3VTe8hORenFKpSzEjjFHdlBqoBQIXUoVnb3/CbT7dYkrVemhurc/Jktg==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr5478961wru.305.1567005241662; 
 Wed, 28 Aug 2019 08:14:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o8sm6019733wma.1.2019.08.28.08.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 08:14:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E9651FF87;
 Wed, 28 Aug 2019 16:14:00 +0100 (BST)
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-4-berrange@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190823163931.7442-4-berrange@redhat.com>
Date: Wed, 28 Aug 2019 16:14:00 +0100
Message-ID: <878srd5nlz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 3/4] docs: document use of automatic
 cleanup functions in glib
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Document the use of g_autofree and g_autoptr in glib for automatic
> freeing of memory, or other resource cleanup (eg mutex unlocking).
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  CODING_STYLE.md | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/CODING_STYLE.md b/CODING_STYLE.md
> index 9f4fc9dc77..f37b6c2d01 100644
> --- a/CODING_STYLE.md
> +++ b/CODING_STYLE.md
> @@ -479,3 +479,104 @@ terminate QEMU.
>
>  Note that &error_fatal is just another way to exit(1), and &error_abort
>  is just another way to abort().
> +
> +
> +## Automatic memory deallocation
> +
> +QEMU has a mandatory dependency either the GCC or CLang compiler. As
> +such it has the freedom to make use of a C language extension for
> +automatically running a cleanup function when a stack variable goes
> +out of scope. This can be used to simplify function cleanup paths,
> +often allowing many goto jumps to be eliminated, through automatic
> +free'ing of memory.
> +
> +The GLib2 library provides a number of functions/macros for enabling
> +automatic cleanup:
> +
> + https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html
> +
> +Most notably:
> +
> + - g_autofree - will invoke g_free() on the variable going out of scope
> +
> + - g_autoptr - for structs / objects, will invoke the cleanup func creat=
ed
> +               by a previous use of G_DEFINE_AUTOPTR_CLEANUP_FUNC. This =
is
> +               supported for most GLib data types and GObjects
> +
> +For example, instead of
> +
> +    int somefunc(void) {
> +        int ret =3D -1;
> +        char *foo =3D g_strdup_printf("foo%", "wibble");
> +        GList *bar =3D .....
> +
> +        if (eek) {
> +           goto cleanup;
> +        }
> +
> +        ret =3D 0;
> +
> +      cleanup:
> +        g_free(foo);
> +        g_list_free(bar);
> +        return ret;
> +    }
> +
> +Using g_autofree/g_autoptr enables the code to be written as:
> +
> +    int somefunc(void) {
> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return -1;
> +        }
> +
> +        return 0;
> +    }
> +
> +While this generally results in simpler, less leak-prone code, there
> +are still some caveats to beware of
> +
> + * Variables declared with g_auto* MUST always be initialized,
> +   otherwise the cleanup function will use uninitialized stack memory
> +
> + * If a variable declared with g_auto* holds a value which must
> +   live beyond the life of the function, that value must be saved
> +   and the original variable NULL'd out. This can be simpler using
> +   g_steal_pointer
> +
> +
> +    char *somefunc(void) {
> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return NULL;
> +        }
> +
> +        return g_steal_pointer(&foo);
> +    }

All good so far.

> +
> +The cleanup functions are not restricted to simply free'ing memory. The
> +GMutexLocker class is a variant of GMutex that has automatic locking and
> +unlocking at start and end of the enclosing scope
> +
> +In the following example, the `lock` in `MyObj` will be held for the
> +precise duration of the `somefunc` function
> +
> +    typedef struct {
> +        GMutex lock;
> +    } MyObj;
> +
> +    char *somefunc(MyObj *obj) {
> +        g_autofree GMutexLocker *locker =3D g_mutex_locker_new(&obj->loc=
k)
> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return NULL;
> +        }
> +
> +        return g_steal_pointer(&foo);
> +    }

I would personally prefer we get some RFC patches for auto-unlocking under =
our
belt before we codify it's usage in our developer docs. Locking is a
fickle beast at the best of times and I'd like to see where it benefits
us before there is a rush to covert to the new style.

For one thing the only uses I see of g_mutex_lock is in our tests, the
main code base uses qemu_mutex_lock. How would we go about registering
the clean-up functions for those in the code base?

But apart from the lock stuff:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

