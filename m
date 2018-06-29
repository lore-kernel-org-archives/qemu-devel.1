Received: from eggs.gnu.org ([2001:4830:134:3::10]:56560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ0Op-0000Yu-Gz
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ0Ok-0007ty-Ud
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:53:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fZ0Ok-0007tX-Pj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:53:42 -0400
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d5a8cdd-bf7a-2dd2-b97f-dfcaa37111c6@redhat.com>
Date: Fri, 29 Jun 2018 15:53:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180629195544.34263-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On 06/29/2018 02:55 PM, Eric Blake wrote:

> The generated qapi-introspect.c changes only with the addition
> of comments, such as:
> 
> | @@ -14927,6 +15410,7 @@
> |          {}
> |      })),
> |      QLIT_QDICT(((QLitDictEntry[]) {
> | +        /* QCryptoBlockInfoLUKSSlot */
> |          { "members", QLIT_QLIST(((QLitObject[]) {
> |              QLIT_QDICT(((QLitDictEntry[]) {
> |                  { "name", QLIT_QSTR("active") },

---
...

> @@ -128,6 +131,8 @@ const QLitObject %(c_name)s = %(c_string)s;
> 
>       def _gen_qlit(self, name, mtype, obj):
>           if mtype not in ('command', 'event', 'builtin', 'array'):
> +            if not self._unmask:
> +                obj['comment'] = name

If desired, we could change this to:

if not self._unmask:
     obj['comment'] = '"%s" = %s' % (self._name(name), name)

to produce comments like /* "0" = q_empty */

for even easier debugging (if I see a line containing "ret-type", 
QLIT_QSTR("0"), then I can grep for '"0" =' to directly look up the type 
name, rather than having to grep for 'name.*"0"' then scrolling back to 
find the associated comment).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
