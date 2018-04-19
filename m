Received: from eggs.gnu.org ([2001:4830:134:3::10]:39432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f93Iv-0005yP-I0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f93Ir-0006MX-Mp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:44:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f93Ir-0006Ls-IZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:44:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03B7A406803E
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:44:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
Date: Thu, 19 Apr 2018 08:44:08 +0200
In-Reply-To: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 17 Apr 2018 15:35:57 +0200")
Message-ID: <87r2nbwv9j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Simplify qobject refcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series aims to get rid of the distinction between QObject, that
> must use qobject_incref/qobject_decref and its various derived types
> that have to use QINCREF/QDECREF. Instead, replace it with
> qobject_ref/qobject_unref for all types.

This is a lovely improvement.

However, I think the code can't quite decide whether to embrace or
eschew type casts between QObject and its subtypes.

On the one hand, we provide safe conversion macros QOBJECT() and
qobject_to().  By the way, shouting one but not the other is a bit ugly.

On the other hand, we still use type casts, and enforce "base comes
first" to make them work.

If we want to eschew type casts, we should clean up the remaining ones.
The case for "base must come first" is quite weak then.  Not worth the
bother, I think.

I doubt we want to embrace type casts here.  If we wanted to, I'd go all
the way and unwrap base in QObjects and its subtypes with suitable "must
match QObject" comments.  Alternatively, use an unnamed member.  Then
convert with type casts rather than container_of() and &->base.
