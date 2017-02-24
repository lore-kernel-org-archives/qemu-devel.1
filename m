Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1chDV1-0006uh-QD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1chDUy-0001Pw-L9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:53:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1chDUy-0001Nr-Cl
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:53:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7774C7FB83
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:53:16 +0000 (UTC)
Date: Fri, 24 Feb 2017 11:53:12 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170224105312.7lephvjbipszrb3p@eukaryote>
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
	<87ino1gcx2.fsf@dusky.pond.sub.org>
	<20170223163315.w2nekel42grwtbkc@eukaryote>
	<36a8c750-8490-1c5d-ca12-cc2b8c594334@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a8c750-8490-1c5d-ca12-cc2b8c594334@redhat.com>
Subject: Re: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 23, 2017 at 10:51:38AM -0600, Eric Blake wrote:
> On 02/23/2017 10:33 AM, Kashyap Chamarthy wrote:

[...]

> > I tried to come up with the below JSON, after looking at the QAPI schema
> > documentation (from qemu/qapi/block-core.json), still I seem to be
> > tripping up somewhere.  Now it doesn't recognize the 'backing' option:
> > 
> > $ socat UNIX:./qmp-sock READLINE,history=$HOME/.qmp_history,prompt='QMP> '
> > [...]
> > QMP> {
> > QMP>   "execute":"blockdev-add",
> > QMP>   "arguments":{
> > QMP>     "driver":"qcow2",
> > QMP>     "node-name":"node1"
> > QMP>   },
> 
> Oops, you ended your arguments too soon.

Sigh, that was a stray closing bracket that I didn't clean up (it was
part of the "cache" section that I borrowed from the schema docs).

> > QMP>   "file":{
> > QMP>     "driver":"file",
> > QMP>     "filename":"/export/target.qcow2"
> > QMP>   },
> > QMP>   "backing":{
> 
> Here, you passed "file" and "backing" as siblings of "execute", but they
> should be children of "arguments".

Oops, you're right.

[...]

> Try (untested on my end) this rewrite of your original post (just
> removing the '"options":{' and corresponding '}' from that listing):
> 
> {
>     "execute": "blockdev-add",
>     "arguments": {
>             "backing": "virtio0",
>             "driver": "qcow2",
>             "id": "virtio1",
>             "file": {
>                 "driver": "file",
>                 "filename": "/export/target.qcow2"
>             }
>     }
> }

This does not work (tested), because my current QEMU build from Git,
will reject the "id" key (Kevin mentioned so on IRC, but I couldn't
find the relevant Git commit from my `grep`ing in the Git history):

{"error": {"class": "GenericError", "desc": "QMP input object member 'id' is unexpected"}}
 
> or this attempt at your current post:
> 
> {   "execute":"blockdev-add",
>     "arguments":{
>      "driver":"qcow2",
>      "node-name":"node1"

A comma missing here :-)  With that fixed, it returns success.  

However, bizzarely enough, when I ran `query-block` after `blockdev-add`
succeeded (well, at least after it returned success), I don't see the
new node ('target.qcow2') reflected in the return output.  Me
investigates.

https://kashyapc.fedorapeople.org/virt/temp/blockdev-add-followed-by-buggy-query-block.txt

>      "file":{
>       "driver":"file",
>       "filename":"/export/target.qcow2"
>      },
>      "backing":{
>       "driver":"qcow2",
>       "file":{
>         "driver":"file",
>         "filename":"/export/base.qcow2"
>       }
>      }
>     }
> }

Just for completeness, the new working incantation (that removes the
need for "options" indirection, and the "id" key) that takes
'node-name':

--------------------------------------------
{
  "execute":"blockdev-add",
  "arguments":{
    "driver":"qcow2",
    "node-name":"node1",
    "file":{
      "driver":"file",
      "filename":"/export/target.qcow2"
    },
    "backing":{
      "driver":"qcow2",
      "file":{
        "driver":"file",
        "filename":"/export/base.qcow2"
      }
    }
  }
}
--------------------------------------------

-- 
/kashyap
