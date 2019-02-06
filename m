Received: from eggs.gnu.org ([209.51.188.92]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grRyP-0007RL-5i
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grRyH-0000HB-PO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:31:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grRyH-00005z-Ij
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:30:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so8950531qtr.12
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 10:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-16-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-16-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Feb 2019 19:30:23 +0100
Message-ID: <CAMxuvayWQawJ3we4bJF7npZgaUWqZvKAK3uik5EO7826DcrnYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/17] Revert "qapi-events: add 'if'
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
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi

On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.
>
> The commit applied the events' conditions to the members of enum
> QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
> target-independent code as soon as we make an event target-dependent.

Well, my solution didn't have this problem iirc. You could mention
that by having target-specific event enums, we could solve this.
It might be worth a FIXME too.

> Reverting this has the following effects:
>
> * ui/vnc.c can remain target independent.
>
> * monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.
>
> * query-events again doesn't reflect conditionals.  I'm going to
>   deprecate it in favor of query-qmp-schema.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

But that's ok for now:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qapi/events.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 28bbc3745d..2067660be4 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -193,7 +193,9 @@ void %(event_emit)s(%(event_enum)s event, QDict *qdic=
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
