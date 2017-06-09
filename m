Received: from eggs.gnu.org ([2001:4830:134:3::10]:39007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dJLq2-0007M9-85
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dJLq1-0001Lu-92
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:28:38 -0400
MIME-Version: 1.0
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-2-eblake@redhat.com>
In-Reply-To: <20170609152017.7286-2-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 09 Jun 2017 15:28:24 +0000
Message-ID: <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

Hi

On Fri, Jun 9, 2017 at 7:20 PM Eric Blake <eblake@redhat.com> wrote:

> A recent patch submission was about to use qobject_decref(QOBJECT(E)),
> even though we already have QDECREF(E) for that purpose.  While our
> tree is currently free from the longhand form, we might as well update
>

Oh?

 $ git grep 'object_unref(OBJECT('  | wc -l
152

our coccinelle script to catch any future relapses.
>

sadly, coccinelle is unabarebly slow on my machine, not easy to grasp, and
thereby fails to catch a lot of cases.. I am looking at alternative from
clang tools/lib, by curiosity.


>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  scripts/coccinelle/qobject.cocci | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/coccinelle/qobject.cocci
> b/scripts/coccinelle/qobject.cocci
> index 97703a4..656dc3e 100644
> --- a/scripts/coccinelle/qobject.cocci
> +++ b/scripts/coccinelle/qobject.cocci
> @@ -3,6 +3,12 @@
>  expression Obj, Key, E;
>  @@
>  (
> +- qobject_incref(QOBJECT(E));
> ++ QINCREF(E);
> +|
> +- qobject_decref(QOBJECT(E));
> ++ QDECREF(E);
> +|
>  - qdict_put_obj(Obj, Key, QOBJECT(E));
>  + qdict_put(Obj, Key, E);
>  |
> --
> 2.9.4
>
>
> --
Marc-Andr=C3=A9 Lureau
