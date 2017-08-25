Received: from eggs.gnu.org ([2001:4830:134:3::10]:55797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCfZ-0008Eo-Fh
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCfX-0006iE-Lp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:20:57 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlCfX-0006hS-Dc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:20:55 -0400
Received: by mail-ua0-x241.google.com with SMTP id d12so878558uag.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 04:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-13-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 11:20:44 +0000
Message-ID: <CAJ+F1C+Q8UHdBGaS1sDS7Eg4onzthw7W_HShaCG0v_9DQssTLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/16] qapi-schema: Move block events
 from event.json to block.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>

On Thu, Aug 24, 2017 at 9:25 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qapi/block.json | 68
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/event.json | 68
> ---------------------------------------------------------
>  2 files changed, 68 insertions(+), 68 deletions(-)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index 414b61b..8ce3357 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -277,3 +277,71 @@
>  ##
>  { 'enum': 'QuorumOpType',
>    'data': [ 'read', 'write', 'flush' ] }
> +
> +##
> +# @QUORUM_FAILURE:
> +#
> +# Emitted by the Quorum block driver if it fails to establish a quorum
> +#
> +# @reference: device name if defined else node name
> +#
> +# @sector-num: number of the first sector of the failed read operation
> +#
> +# @sectors-count: failed read operation sector count
> +#
> +# Note: This event is rate-limited.
> +#
> +# Since: 2.0
> +#
> +# Example:
> +#
> +# <- { "event": "QUORUM_FAILURE",
> +#      "data": { "reference": "usr1", "sector-num": 345435,
> "sectors-count": 5 },
> +#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
> +#
> +##
> +{ 'event': 'QUORUM_FAILURE',
> +  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count':
> 'int' } }
> +
> +##
> +# @QUORUM_REPORT_BAD:
> +#
> +# Emitted to report a corruption of a Quorum file
> +#
> +# @type: quorum operation type (Since 2.6)
> +#
> +# @error: error message. Only present on failure. This field
> +#         contains a human-readable error message. There are no semantic=
s
> other
> +#         than that the block layer reported an error and clients should
> not
> +#         try to interpret the error string.
> +#
> +# @node-name: the graph node name of the block driver state
> +#
> +# @sector-num: number of the first sector of the failed read operation
> +#
> +# @sectors-count: failed read operation sector count
> +#
> +# Note: This event is rate-limited.
> +#
> +# Since: 2.0
> +#
> +# Example:
> +#
> +# 1. Read operation
> +#
> +# { "event": "QUORUM_REPORT_BAD",
> +#      "data": { "node-name": "node0", "sector-num": 345435,
> "sectors-count": 5,
> +#                "type": "read" },
> +#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
> +#
> +# 2. Flush operation
> +#
> +# { "event": "QUORUM_REPORT_BAD",
> +#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count":
> 2097120,
> +#                "type": "flush", "error": "Broken pipe" },
> +#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
> +#
> +##
> +{ 'event': 'QUORUM_REPORT_BAD',
> +  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
> +            'sector-num': 'int', 'sectors-count': 'int' } }
> diff --git a/qapi/event.json b/qapi/event.json
> index a043de4..48a5d8f 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -92,74 +92,6 @@
>    'data': { 'actual': 'int' } }
>
>  ##
> -# @QUORUM_FAILURE:
> -#
> -# Emitted by the Quorum block driver if it fails to establish a quorum
> -#
> -# @reference: device name if defined else node name
> -#
> -# @sector-num: number of the first sector of the failed read operation
> -#
> -# @sectors-count: failed read operation sector count
> -#
> -# Note: This event is rate-limited.
> -#
> -# Since: 2.0
> -#
> -# Example:
> -#
> -# <- { "event": "QUORUM_FAILURE",
> -#      "data": { "reference": "usr1", "sector-num": 345435,
> "sectors-count": 5 },
> -#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
> -#
> -##
> -{ 'event': 'QUORUM_FAILURE',
> -  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count':
> 'int' } }
> -
> -##
> -# @QUORUM_REPORT_BAD:
> -#
> -# Emitted to report a corruption of a Quorum file
> -#
> -# @type: quorum operation type (Since 2.6)
> -#
> -# @error: error message. Only present on failure. This field
> -#         contains a human-readable error message. There are no semantic=
s
> other
> -#         than that the block layer reported an error and clients should
> not
> -#         try to interpret the error string.
> -#
> -# @node-name: the graph node name of the block driver state
> -#
> -# @sector-num: number of the first sector of the failed read operation
> -#
> -# @sectors-count: failed read operation sector count
> -#
> -# Note: This event is rate-limited.
> -#
> -# Since: 2.0
> -#
> -# Example:
> -#
> -# 1. Read operation
> -#
> -# { "event": "QUORUM_REPORT_BAD",
> -#      "data": { "node-name": "node0", "sector-num": 345435,
> "sectors-count": 5,
> -#                "type": "read" },
> -#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
> -#
> -# 2. Flush operation
> -#
> -# { "event": "QUORUM_REPORT_BAD",
> -#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count":
> 2097120,
> -#                "type": "flush", "error": "Broken pipe" },
> -#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
> -#
> -##
> -{ 'event': 'QUORUM_REPORT_BAD',
> -  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
> -            'sector-num': 'int', 'sectors-count': 'int' } }
> -
> -##
>  # @MEM_UNPLUG_ERROR:
>  #
>  # Emitted when memory hot unplug error occurs.
> --
> 2.7.5
>
>
> --
Marc-Andr=C3=A9 Lureau
