Received: from eggs.gnu.org ([2001:4830:134:3::10]:47884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzhh-0006dj-Hs
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzhd-0005Uo-5n
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYzhc-0005TI-UX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:09:09 -0400
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed5d831b-2035-74b5-b12a-01f443c8a896@redhat.com>
Date: Fri, 29 Jun 2018 15:09:06 -0500
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
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/29/2018 02:55 PM, Eric Blake wrote:
> We consciously chose in commit 1a9a507b to hide QAPI type names
> from the generated introspection output, but added a command line
> option -u to unmask the type name when doing a debug build.  At
> that time, we generated a monolithic C string, so there was no
> better way to do things (we could not really inject comments).
> 
> Later, in commit 7d0f982b, we switched the generation to output
> a QLit object, in part to make it easier for future addition of
> conditional compilation.  But this switch has also made it easier
> to interject strategic comments.  That commit also forgot to
> delete some now-stale comments about long generated line lengths.
> 
> For now, type name debug aid comments are only output once per
> meta-type, rather than at all uses of the number used to encode
> the type to the introspection data.  But this is still a lot
> more convenient than having to regenerate the file with the
> unmask operation temporarily turned on.
...

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   scripts/qapi/introspect.py | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Misses a change to docs/devel/qapi-code.gen.tx:

diff --git i/docs/devel/qapi-code-gen.txt w/docs/devel/qapi-code-gen.txt
index 88a70e4d451..0c98c7d7b6c 100644
--- i/docs/devel/qapi-code-gen.txt
+++ w/docs/devel/qapi-code-gen.txt
@@ -1392,6 +1392,7 @@ Example:
              { }
          })),
          QLIT_QDICT(((QLitDictEntry[]) {
+            /* q_empty */
              { "members", QLIT_QLIST(((QLitObject[]) {
                  { }
              })) },

> @@ -118,8 +121,8 @@ const QLitObject %(c_name)s = %(c_string)s;
>           if typ not in self._used_types:
>               self._used_types.append(typ)
>           # Clients should examine commands and events, not types.  Hide
> -        # type names to reduce the temptation.  Also saves a few
> -        # characters.
> +        # type names as integers to reduce the temptation, but provide
> +        # comments for debugging aid.

When I wrote the patch, I assumed the final sentence of the comment was 
talking about fewer characters in the generated .c file (I nuked it, 
since adding comments makes for a longer, not shorter, generated .c 
file); but now that I'm writing this email, I see it could also refer to 
fewer characters sent over the wire in the QMP command (which length is 
unchanged by this patch, but was a 13KiB savings compared to the 
unmasked version, per commit 1a9a507b).  So feel free to bikeshed this 
comment.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
