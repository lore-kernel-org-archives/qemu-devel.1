Received: from eggs.gnu.org ([2001:4830:134:3::10]:34955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZLF0-00059q-JQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZLB6-0001Ye-Tk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:37:17 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZLB6-0001UZ-L2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:37:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so17129971wrt.7
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 11:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-14-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-14-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Dec 2018 23:37:04 +0400
Message-ID: <CAJ+F1CLnugfZKFaQTjK3oAPJ3PmsxvBwhDtD8mH-D1FnUqKKgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] Revert "qapi-events: add 'if'
 condition to implicit event enum"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Dec 18, 2018 at 10:27 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.
>
> The commit applied the events' conditions to the members of enum
> QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
> target-independent code as soon as we make an event target-dependent.
> Reverting this has the following effects:
>
> * ui/vnc.c can remain target independent.

Was it ever moved? I don't recall

>
> * monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.

I suggested a way to get rid of monitor_qapi_event_conf[] in the patch
message, by having the rate stored in the schema, which could actually
be useful (for doc, introspection etc).

>
> * query-events again doesn't reflect conditionals.  I'm going to
>   deprecate it in favor of query-qmp-schema.

I guess that's not that important.

I have a slight preference for not declaring enums when the related
option is disabled.

But people don't like having too much #ifdef code, which is understandable.

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> # Conflicts:
> #       scripts/qapi/events.py
> ---
>  scripts/qapi/events.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index e988e43941..c944ba90b8 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -194,7 +194,9 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdic=
t);
>              self._genc.add(gen_event_send(name, arg_type, boxed,
>                                            self._event_enum_name,
>                                            self._event_emit_name))
> -        self._event_enum_members.append(QAPISchemaMember(name, ifcond))
> +        # Note: we generate the enum member regardless of @ifcond, to
> +        # keep the enumeration usable in target-independent code.
> +        self._event_enum_members.append(QAPISchemaMember(name))
>
>
>  def gen_events(schema, output_dir, prefix):
> --
> 2.17.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
