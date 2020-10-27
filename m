Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E28C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A48820724
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE0YdNyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A48820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTqR-0005Yt-2X
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXTd0-0006IS-Gc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXTcw-0003IU-W7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603823002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6u7wn5Id4RTYnXWc0rndcBGVceFSO9REzs3OxgkRWVc=;
 b=LE0YdNynaLELFj0BECGZlf8/HpcZJ2VHPQ/r1Nf8Q0poHNnkUWXqxptQoLLGnDrljzE7KV
 3OJuUiSjC8zeLeXDZSPU+3oiUpOpTAUBVfWwmOIdt4VRs0BdILRyxEOSOBumUfbUOXxVPe
 wZk6Om7yx/dhZsjOi6x6rRImCc3OjgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Q6VoBedcOqCtBjUDuYOX0Q-1; Tue, 27 Oct 2020 14:23:18 -0400
X-MC-Unique: Q6VoBedcOqCtBjUDuYOX0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D70EC502;
 Tue, 27 Oct 2020 18:23:17 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D5D710013D0;
 Tue, 27 Oct 2020 18:23:14 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201026101005.2940615-1-armbru@redhat.com>
 <20201026101005.2940615-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH 3/4] char: Flat alternative to overly nested chardev-add
 arguments
Message-ID: <df6a32e6-3b4c-d9d7-b473-9bdd7c674843@redhat.com>
Date: Tue, 27 Oct 2020 13:23:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026101005.2940615-4-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 5:10 AM, Markus Armbruster wrote:
> chardev-add's arguments use an annoying amount of nesting.  Example:
> 
>     {"execute": "chardev-add",
>      "arguments": {
>          "id":"sock0",
> 	 "backend": {
> 	     "type": "socket",
> 	     "data": {
> 	         "addr": {
> 		     "type": "inet",
> 		     "data": {
> 		         "host": "0.0.0.0",
> 			 "port": "2445"}}}}}}
> 
> This is because chardev-add predates QAPI features that enable flatter
> data structures, both on the wire and in C: base types, flat unions,
> commands taking a union or alternate as 'data'.
> 
> The nesting would be even more annoying in dotted key syntax:
> 
>     id=sock0,\
>     backend.type=socket,\
>     backend.data.addr.type=inet,\
>     backend.data.addr.data.host=0.0.0.0,\
>     backend.data.addr.data.port=2445
> 
> Relevant, because the next commit will QAPIfy qemu-storage-daemon
> --chardev.  We really want this instead:
> 
>     --chardev socket,id=sock0,\
>     addr.type=inet,\
>     addr.host=0.0.0.0,\
>     addr.port=2445
> 
> To get it, define a new QAPI type ChardevOptions that is the flat
> equivalent to chardev-add's arguments.
> 
> What we should do now is convert the internal interfaces to take this
> new type, and limit the nested old type to the external interface,
> similar to what commit bd269ebc82 "sockets: Limit SocketAddressLegacy
> to external interfaces" did.  But we're too close to the freeze to
> pull that off safely.
> 
> What I can do now is convert the new type to the old nested type, and
> promise to replace this by what should be done in the next development
> cycle.

Nice evaluation of the trade-off.

> 
> In more detail:
> 
> * Flat union ChardevOptions corresponds to chardev-add's implicit
>   arguments type.  It flattens a struct containing a simple union into
>   a flat union.
> 
> * The flat union's discriminator is named @backend, not @type.  This
>   avoids clashing with member @type of ChardevSpiceChannel.  For what
>   it's worth, -chardev also uses this name.
> 
> * Its branches @socket, @udp use ChardevSocketFlat, ChardevUdpFlat
>   instead of ChardevSocket, ChardevUdp.  This flattens simple union
>   SocketAddressLegacy members to flat union SocketAddress members.
> 
> * New chardev_options_crumple() converts ChardevOptions to
>   chardev-add's implict arguments type.

implicit

> 
> Only one existing QAPI definition is affected: some of ChardevSocket's
> members get moved to a new base type ChardevSocketBase, to reduce
> duplication.  No change to the generated C type and the wire format.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/char.json         | 106 ++++++++++++++++++++++++++++---
>  include/chardev/char.h |   5 ++
>  include/qemu/sockets.h |   3 +
>  chardev/char-legacy.c  | 140 +++++++++++++++++++++++++++++++++++++++++
>  chardev/char-socket.c  |   3 +-
>  util/qemu-sockets.c    |  38 +++++++++++
>  chardev/meson.build    |   1 +
>  7 files changed, 287 insertions(+), 9 deletions(-)
>  create mode 100644 chardev/char-legacy.c

Big but worth it.  I'm liking the simplicity of this alternative over
Kevin's proposal, especially if we're aiming to get this in 5.2 soft freeze.

> 
> diff --git a/qapi/char.json b/qapi/char.json
> index 43486d1daa..31b693bbb2 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -244,12 +244,8 @@
>    'base': 'ChardevCommon' }
>  
>  ##
> -# @ChardevSocket:
> +# @ChardevSocketBase:
>  #
> -# Configuration info for (stream) socket chardevs.
> -#
> -# @addr: socket address to listen on (server=true)
> -#        or connect to (server=false)
>  # @tls-creds: the ID of the TLS credentials object (since 2.6)
>  # @tls-authz: the ID of the QAuthZ authorization object against which
>  #             the client's x509 distinguished name will be validated. This
> @@ -274,9 +270,8 @@
>  #
>  # Since: 1.4
>  ##
> -{ 'struct': 'ChardevSocket',
> -  'data': { 'addr': 'SocketAddressLegacy',
> -            '*tls-creds': 'str',
> +{ 'struct': 'ChardevSocketBase',
> +  'data': { '*tls-creds': 'str',
>              '*tls-authz'  : 'str',
>              '*server': 'bool',
>              '*wait': 'bool',
> @@ -287,6 +282,35 @@
>              '*reconnect': 'int' },
>    'base': 'ChardevCommon' }

Here we are subdividing ChardevSocket into everything that is already
flat, and excluding the awkward 'addr'...

>  
> +##
> +# @ChardevSocket:
> +#
> +# Configuration info for (stream) socket chardevs.
> +#
> +# @addr: socket address to listen on (server=true)
> +#        or connect to (server=false)
> +#
> +# Since: 1.4
> +##
> +{ 'struct': 'ChardevSocket',
> +  # Do not add to 'data', it breaks chardev_options_crumple()!  Add to
> +  # ChardevSocketBase's 'data' instead.
> +  'data': { 'addr': 'SocketAddressLegacy' },
> +  'base': 'ChardevSocketBase' }

...legacy use pulls in the legacy 'addr'...

> +
> +##
> +# @ChardevSocketFlat:
> +#
> +# Note: This type should eventually replace ChardevSocket.  The
> +#       difference between the two: ChardevSocketFlat uses
> +#       SocketAddressLegacy, ChardevSocket uses SocketAddress.
> +##

Missing a 'Since: 5.2' tag, if you want one.

> +{ 'struct': 'ChardevSocketFlat',
> +  # Do not add to 'data', it breaks chardev_options_crumple()!  Add to
> +  # ChardevSocketBase's 'data' instead.
> +  'data': { 'addr': 'SocketAddress' },
> +  'base': 'ChardevSocketBase' }
> +

...and this is the new type with a saner 'addr'.  Works for me so far.

>  ##
>  # @ChardevUdp:
>  #
> @@ -298,10 +322,26 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevUdp',
> +  # Do not add to 'data', it breaks chardev_options_crumple()!  Create
> +  # ChardevUdpBase instead, similar to ChardevSocketBase.
>    'data': { 'remote': 'SocketAddressLegacy',
>              '*local': 'SocketAddressLegacy' },
>    'base': 'ChardevCommon' }
>  
> +##
> +# @ChardevUdpFlat:
> +#
> +# Note: This type should eventually replace ChardevUdp.  The
> +#       difference between the two: ChardevUdpFlat uses
> +#       SocketAddressLegacy, ChardevUdp uses SocketAddress.
> +##

Another missing 'Since: 5.2'

> +{ 'struct': 'ChardevUdpFlat',
> +  # Do not add to 'data', it breaks chardev_options_crumple()!  Create
> +  # ChardevUdpBase instead, similar to ChardevSocketBase.
> +  'data': { 'remote': 'SocketAddress',
> +            '*local': 'SocketAddress' },
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevMux:
>  #
> @@ -422,6 +462,56 @@
>              # next one is just for compatibility
>              'memory': 'ChardevRingbuf' } }
>  
> +##
> +# @ChardevBackendType:
> +#
> +# Since: 5.2
> +##
> +{ 'enum': 'ChardevBackendType',
> +
> +  'data': [ 'file', 'serial', 'parallel', 'pipe', 'socket', 'udp',
> +            'pty', 'null', 'mux', 'msmouse', 'wctablet', 'braille',
> +            'testdev', 'stdio', 'console', 'spicevmc', 'spiceport',
> +            'vc', 'ringbuf' ] }
> +
> +##
> +# @ChardevOptions:
> +#
> +# Note: This type should eventually replace the implicit arguments
> +#       type of chardev-add and chardev-chardev.  The differences
> +#       between the two: 1. ChardevSocketOptions is a flat union
> +#       rather than a struct with a simple union member, and 2. it
> +#       uses SocketAddress instead of SocketAddressLegacy.  This
> +#       avoids nesting on the wire, i.e. we need fewer {}.
> +#
> +# Since: 5.2
> +##
> +{ 'union': 'ChardevOptions',
> +  'base': { 'backend': 'ChardevBackendType',
> +            'id': 'str' },
> +  'discriminator': 'backend',
> +  'data': { 'file': 'ChardevFile',
> +            'serial': 'ChardevHostdev',
> +            'parallel': 'ChardevHostdev',
> +            'pipe': 'ChardevHostdev',
> +            'socket': 'ChardevSocketFlat',
> +            'udp': 'ChardevUdpFlat',
> +            'pty': 'ChardevCommon',
> +            'null': 'ChardevCommon',
> +            'mux': 'ChardevMux',
> +            'msmouse': 'ChardevCommon',
> +            'wctablet': 'ChardevCommon',
> +            'braille': 'ChardevCommon',
> +            'testdev': 'ChardevCommon',
> +            'stdio': 'ChardevStdio',
> +            'console': 'ChardevCommon',
> +            'spicevmc': { 'type': 'ChardevSpiceChannel',
> +                          'if': 'defined(CONFIG_SPICE)' },
> +            'spiceport': { 'type': 'ChardevSpicePort',
> +                           'if': 'defined(CONFIG_SPICE)' },
> +            'vc': 'ChardevVC',
> +            'ringbuf': 'ChardevRingbuf' } }

Looks good from the QAPI point of view.


> +/*
> + * TODO Convert internal interfaces to ChardevOptions, replace this
> + * function by one that flattens (const char *str, ChardevBackend
> + * *backend) -> ChardevOptions.
> + */
> +q_obj_chardev_add_arg *chardev_options_crumple(ChardevOptions *chr)
> +{
> +    q_obj_chardev_add_arg *arg;
> +    ChardevBackend *be;
> +
> +    if (!chr) {
> +        return NULL;
> +    }
> +
> +    arg = g_malloc(sizeof(*arg));
> +    arg->id = g_strdup(chr->id);
> +    arg->backend = be = g_malloc(sizeof(*be));
> +
> +    switch (chr->backend) {
> +    case CHARDEV_BACKEND_TYPE_FILE:
> +        be->type = CHARDEV_BACKEND_KIND_FILE;
> +        be->u.file.data = QAPI_CLONE(ChardevFile, &chr->u.file);
> +        break;

Most branches are straightforward,...

> +    case CHARDEV_BACKEND_TYPE_SOCKET:
> +        be->type = CHARDEV_BACKEND_KIND_SOCKET;
> +        /*
> +         * Clone with SocketAddress crumpled to SocketAddressLegacy.
> +         * All other members are in the base type.
> +         */
> +        be->u.socket.data = g_memdup(&chr->u.socket, sizeof(chr->u.socket));
> +        QAPI_CLONE_MEMBERS(ChardevSocketBase,
> +                           qapi_ChardevSocket_base(be->u.socket.data),
> +                           qapi_ChardevSocketFlat_base(&chr->u.socket));
> +        be->u.socket.data->addr = socket_address_crumple(chr->u.socket.addr);
> +        break;

...and this looks correct as well.

> +++ b/chardev/char-socket.c
> @@ -1404,7 +1404,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>  
>      backend->type = CHARDEV_BACKEND_KIND_SOCKET;
>      sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
> -    qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
> +    qemu_chr_parse_common(opts,
> +            qapi_ChardevSocketBase_base(qapi_ChardevSocket_base(sock)));

The double function call (for a double cast) looks unusual, but I don't
see any shorter expression, so it is fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


