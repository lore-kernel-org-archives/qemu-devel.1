Received: from eggs.gnu.org ([2001:4830:134:3::10]:57685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUt6e-00065a-8j
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUt6a-00020U-BY
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:50:16 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUt6Z-0001yj-Jx
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:50:12 -0500
Received: by mail-wr1-f53.google.com with SMTP id z5so333905wrt.11
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:50:11 -0800 (PST)
References: <20181206121743.20762-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa022957-1015-9173-6e17-c683f1a39392@redhat.com>
Date: Thu, 6 Dec 2018 13:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181206121743.20762-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] json: Fix to reject duplicate object
 member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, mreitz@redhat.com

On 12/6/18 1:17 PM, Markus Armbruster wrote:
> The JSON parser happily accepts duplicate object member names.  The
> last value wins.  Reproducer #1:
> 
>     $ qemu-system-x86_64 -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
>     "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
>     {'execute':'qmp_capabilities'}
>     {"return": {}}
>     {'execute':'blockdev-add','arguments':{'driver':'null-co',
>      'node-name':'foo','node-name':'bar'}}
>     {"return": {}}
>     {'execute':'query-named-block-nodes'}
>     {"return": [{ [...] "node-name": "bar" [...] }]}
> 
> Reproducer #2 is iotest 229.
> 
> Fix the parser to reject duplicates, and fix iotest 229 not to use
> them.

Looks like 2 different patches.

> 
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qobject/json-parser.c  | 5 +++++
>  tests/qemu-iotests/229 | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 5a840dfd86..a86de3f462 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -288,6 +288,11 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
>          goto out;
>      }
>  
> +    if (qdict_haskey(dict, qstring_get_str(key))) {
> +        parse_error(ctxt, token, "duplicate key");
> +        goto out;
> +    }
> +        
>      qdict_put_obj(dict, qstring_get_str(key), value);
>  
>      qobject_unref(key);
> diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
> index 86602437ff..893d098ad2 100755
> --- a/tests/qemu-iotests/229
> +++ b/tests/qemu-iotests/229
> @@ -69,7 +69,6 @@ echo
>  _send_qemu_cmd $QEMU_HANDLE \
>      "{'execute': 'drive-mirror',
>                   'arguments': {'device': 'testdisk',
> -                               'mode':   'absolute-paths',
>                                 'format': '$IMGFMT',
>                                 'target': '$DEST_IMG',
>                                 'sync':   'full',
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
