Received: from eggs.gnu.org ([2001:4830:134:3::10]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtKB-0002Sc-KG
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtK6-0005My-Pr
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:11 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtK6-0005Mt-LK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:57:06 -0500
Received: by mail-qk0-x243.google.com with SMTP id j127so11696158qke.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:57:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-14-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e7a1d05-bf42-e314-5aff-7395011b99ae@amsat.org>
Date: Fri, 3 Mar 2017 16:57:02 -0300
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 13/28] qapi: Make QObject input visitor
 set *list reliably
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 03/03/2017 09:32 AM, Markus Armbruster wrote:
> qobject_input_start_struct() sets *list, except when it fails because
> qobject_input_get_object() fails, i.e. the input object doesn't exist.
>
> All the other input visitor start_struct(), start_list(),
> start_alternate() always set *obj / *list.
>
> Change qobject_input_start_struct() to match.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qapi/qobject-input-visitor.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 2c2f883..d58696c 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -196,25 +196,21 @@ static void qobject_input_start_list(Visitor *v, const char *name,
>      QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
>      const QListEntry *entry;
>
> +    if (list) {
> +        *list = NULL;
> +    }
>      if (!qobj) {
>          return;
>      }
>      if (qobject_type(qobj) != QTYPE_QLIST) {
> -        if (list) {
> -            *list = NULL;
> -        }
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
>                     "list");
>          return;
>      }
>
>      entry = qobject_input_push(qiv, qobj, list);
> -    if (list) {
> -        if (entry) {
> -            *list = g_malloc0(size);
> -        } else {
> -            *list = NULL;
> -        }
> +    if (entry && list) {
> +        *list = g_malloc0(size);
>      }
>  }
>
>
