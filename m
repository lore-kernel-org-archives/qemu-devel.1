Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpF8I-0004Mq-BM
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpF8D-0000VR-PH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:51:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpF8D-0000Ue-HQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:51:45 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-39-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <927571d9-7b7d-642e-42a9-9fc9cd0ed614@redhat.com>
Date: Mon, 13 Aug 2018 10:51:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-39-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 38/56] json: Pass lexical errors and limit
 violations to callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> The callback to consume JSON values takes QObject *json, Error *err.
> If both are null, the callback is supposed to make up an error by
> itself.  This sucks.
> 
> qjson.c's consume_json() neglects to do so, which makes
> qobject_from_json() & friends return null instead of failing.  I
> consider that a bug.
> 
> The culprit is json_message_process_token(): it passes two null
> pointers when it runs into a lexical error or a limit violation.  Fix
> it to pass a proper Error object then.  Update the callbacks:
> 

> +++ b/include/qapi/qmp/qerror.h
> @@ -61,9 +61,6 @@
>   #define QERR_IO_ERROR \
>       "An IO error has occurred"
>   
> -#define QERR_JSON_PARSING \
> -    "Invalid JSON syntax"
> -

Bonus - one less of these annoying defines.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
