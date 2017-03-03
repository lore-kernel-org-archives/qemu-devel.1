Received: from eggs.gnu.org ([2001:4830:134:3::10]:59776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtIY-0001sK-Vj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtIU-0004zN-5i
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:55:31 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtIU-0004zF-0s
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:55:26 -0500
Received: by mail-qk0-x241.google.com with SMTP id g129so1501797qkd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:55:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
Date: Fri, 3 Mar 2017 16:55:22 -0300
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Hi Markus,

On 03/03/2017 09:32 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 23b0528..578c6d8 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>
>      dict = qobject_to_qdict(request);
>      if (!dict) {
> -        error_setg(errp, "Expected '%s' in QMP input", "object");
> +        error_setg(errp, "QMP input must be a JSON object");
>          return NULL;
>      }
>
> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>
>          if (!strcmp(arg_name, "execute")) {
>              if (qobject_type(arg_obj) != QTYPE_QSTRING) {
> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
> -                           "execute", "string");
> +                error_setg(errp,
> +                           "QMP input object member '%s' must be %s",
> +                           "execute", "a string");

let's avoid formatting like the rest of this patch.

>                  return NULL;
>              }
>              has_exec_key = true;
>          } else if (!strcmp(arg_name, "arguments")) {
>              if (qobject_type(arg_obj) != QTYPE_QDICT) {
> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
> -                           "arguments", "object");
> +                error_setg(errp,
> +                           "QMP input object member '%s' must be %s",
> +                           "arguments", "an object");

same.

>                  return NULL;
>              }
>          } else {
> @@ -60,7 +62,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>      }
>
>      if (!has_exec_key) {
> -        error_setg(errp, "Expected '%s' in QMP input", "execute");
> +        error_setg(errp, "QMP input object lacks key 'execute'");
>          return NULL;
>      }
>
>
