Received: from eggs.gnu.org ([2001:4830:134:3::10]:51959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejAGk-00006x-7D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejAGh-0003KE-0i
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:55:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejAGg-0003K0-SR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:55:06 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25d7eb04-6406-1194-a8e4-3506ea6c2765@redhat.com>
Date: Tue, 6 Feb 2018 14:54:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 17/21] qapi/types qapi/visit: Generate
 built-in stuff into separate files
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

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Linking code from multiple separate QAPI schemata into the same
> program is possible, but involves some weirdness around built-in
> types:
> 
> * We generate code for built-in types into .c only with option
>    --builtins.  The user is responsible to generate code for exactly
>    one QAPI schema per program with --builtins.
> 
> * We generate code for them it into .h regardless of --builtins,

s/them it/them/

>    guarded by #ifndef QAPI_VISIT_BUILTIN.  Because the code for
>    built-in types is exactly the same in all of them, including any
>    combination of these headers works.
> 
> Replace this contraption by something more conventional: generate code
> for built-in types into their very own files: qapi-builtin-types.c,
> qapi-builtin-visit.c, qapi-builtin-types.h, qapi-builtin-visit.h, but
> only with --builtins.  Obey --output-dir, but ignore --prefix for
> them.
> 
> Make qapi-types.h include qapi-builtin-types.h.  With multiple
> schemata you now have multiple qapi-types.[ch], but only one
> qapi-builtin-types.[ch].  Same for qapi-visit.[ch] and
> qapi-builtin-visit.[ch].
> 
> Bonus: if all you need is built-in stuff, you can include a much
> smaller header.  To be exploited shortly.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
