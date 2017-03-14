Received: from eggs.gnu.org ([2001:4830:134:3::10]:44878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnlmx-0001bh-8g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnlmv-00013H-QT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:42:55 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnlmv-00012t-EQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:42:53 -0400
Received: by mail-lf0-x244.google.com with SMTP id y193so14000505lfd.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-26-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 12:42:40 +0000
Message-ID: <CAJ+F1CK+i0HTNU83ftuc9zBcNFm2NSxecajt97QvDZGfj9on8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 25/47] qapi2texi: Include member
 type in generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 10:31 AM Markus Armbruster <armbru@redhat.com>
wrote:

> The recent merge of docs/qmp-commands.txt and docs/qmp-events.txt into
> the schema lost type information.  Fix this documentation regression.
>
> Example change (qemu-qmp-ref.txt):
>
>   -- Struct: InputKeyEvent
>
>       Keyboard input event.
>
>       Members:
> -     'button'
> +     'button: InputButton'
>            Which button this event is for.
> -     'down'
> +     'down: boolean'
>            True for key-down and false for key-up events.
>
>       Since: 2.0
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py      | 14 ++++++++++++++
>  scripts/qapi2texi.py |  8 ++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 9430493..b82a2a6 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1101,6 +1101,11 @@ class QAPISchemaType(QAPISchemaEntity):
>          }
>          return json2qtype.get(self.json_type())
>
> +    def doc_type(self):
> +        if self.is_implicit():
> +            return None
> +        return self.name
> +
>
>  class QAPISchemaBuiltinType(QAPISchemaType):
>      def __init__(self, name, json_type, c_type):
> @@ -1125,6 +1130,9 @@ class QAPISchemaBuiltinType(QAPISchemaType):
>      def json_type(self):
>          return self._json_type_name
>
> +    def doc_type(self):
> +        return self.json_type()
> +
>      def visit(self, visitor):
>          visitor.visit_builtin_type(self.name, self.info,
> self.json_type())
>
> @@ -1184,6 +1192,12 @@ class QAPISchemaArrayType(QAPISchemaType):
>      def json_type(self):
>          return 'array'
>
> +    def doc_type(self):
> +        elt_doc_type =3D self.element_type.doc_type()
> +        if not elt_doc_type:
> +            return None
>

In which case is this expected to happen? place an assert here instead?


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




> +        return 'array of ' + elt_doc_type
> +
>      def visit(self, visitor):
>          visitor.visit_array_type(self.name, self.info, self.element_type=
)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 3dd0146..993b652 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -135,8 +135,12 @@ def texi_enum_value(value):
>
>  def texi_member(member):
>      """Format a table of members item for an object type member"""
> -    return '@item @code{%s}%s\n' % (
> -        member.name, ' (optional)' if member.optional else '')
> +    typ =3D member.type.doc_type()
> +    return '@item @code{%s%s%s}%s\n' % (
> +        member.name,
> +        ': ' if typ else '',
> +        typ if typ else '',
> +        ' (optional)' if member.optional else '')
>
>
>  def texi_members(doc, what, member_func):
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
