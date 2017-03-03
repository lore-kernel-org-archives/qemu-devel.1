Received: from eggs.gnu.org ([2001:4830:134:3::10]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjhh8-0007WI-Rw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjhh4-0001Og-RC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 02:32:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-11-git-send-email-armbru@redhat.com>
	<20170303064035.GR16140@ndevos-x240.usersys.redhat.com>
Date: Fri, 03 Mar 2017 08:31:54 +0100
In-Reply-To: <20170303064035.GR16140@ndevos-x240.usersys.redhat.com> (Niels de
	Vos's message of "Thu, 2 Mar 2017 22:40:35 -0800")
Message-ID: <87y3wm4xzp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/15] gluster: Drop
 assumptions on SocketTransport names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, qemu-devel@nongnu.org, qemu-block@nongnu.org, namei.unix@gmail.com

Niels de Vos <ndevos@redhat.com> writes:

> On Thu, Mar 02, 2017 at 10:44:01PM +0100, Markus Armbruster wrote:
>> qemu_gluster_glfs_init() passes the names of QAPI enumeration type
>> SocketTransport to glfs_set_volfile_server().  Works, because they
>> were chosen to match.  But the coupling is artificial.  Use the
>> appropriate literal strings instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/gluster.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/block/gluster.c b/block/gluster.c
>> index 56b4abe..7236d59 100644
>> --- a/block/gluster.c
>> +++ b/block/gluster.c
>> @@ -412,8 +412,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
>>  
>>      for (server = gconf->server; server; server = server->next) {
>>          if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
>> -            ret = glfs_set_volfile_server(glfs,
>> -                                   GlusterTransport_lookup[server->value->type],
>> +            ret = glfs_set_volfile_server(glfs, "unix",
>>                                     server->value->u.q_unix.path, 0);
>>          } else {
>>              if (parse_uint_full(server->value->u.tcp.port, &port, 10) < 0 ||
>> @@ -423,8 +422,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
>>                  errno = EINVAL;
>>                  goto out;
>>              }
>> -            ret = glfs_set_volfile_server(glfs,
>> -                                   GlusterTransport_lookup[server->value->type],
>> +            ret = glfs_set_volfile_server(glfs, "tcp",
>>                                     server->value->u.tcp.host,
>>                                     (int)port);
>>          }
>> -- 
>> 2.7.4
>
> Instead of the strings for "unix" and "tcp", I would have liked
> #define's. Unfortunately it seems that these are not available in public
> headers :-/

Symbols from glfs.h would be ideal, yes.  But well-known string literals
aren't too bad.

> If this is easier to understand, I don't have any objections.

It's easier to read, but that's not my chief reason.  My chief reason is
that the values glfs_set_volfile_server() accepts are glfs's business,
while the names of the QAPI enumeration constants are QMP's business.
Coupling the two is inappropriate.

Decoupling them enables the renaming of the enumeration constant in
PATCH 14.

> Reviewed-by: Niels de Vos <ndevos@redhat.com>

Thanks!
