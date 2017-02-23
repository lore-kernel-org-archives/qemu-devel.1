Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cgwKb-0005cp-Of
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cgwKW-0003iP-SK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cgwKW-0003hX-NE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:33:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F253B720
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 16:33:20 +0000 (UTC)
Date: Thu, 23 Feb 2017 17:33:15 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170223163315.w2nekel42grwtbkc@eukaryote>
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
	<87ino1gcx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ino1gcx2.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 23, 2017 at 04:11:21PM +0100, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
> 
> > TL;DR: Using `blockdev-add` to create an overlay file succeeds with QEMU
> >        2.7.0, however the *same* test fails with QEMU from Git (plus a
> >        couple of patch series from mailing list).  Details below.
> 
> commit 0153d2f50bc2ad3f41810d838fcf66acbf10f07a
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Fri Oct 7 17:05:04 2016 +0200
> 
>     block: Remove "options" indirection from blockdev-add

[...]

> Sorry for the confusion!  Early adopters always have the most fun ;)

Ah, I see, thanks for the pointer.

I tried to come up with the below JSON, after looking at the QAPI schema
documentation (from qemu/qapi/block-core.json), still I seem to be
tripping up somewhere.  Now it doesn't recognize the 'backing' option:

$ socat UNIX:./qmp-sock READLINE,history=$HOME/.qmp_history,prompt='QMP> '
[...]
QMP> {
QMP>   "execute":"blockdev-add",
QMP>   "arguments":{
QMP>     "driver":"qcow2",
QMP>     "node-name":"node1"
QMP>   },
QMP>   "file":{
QMP>     "driver":"file",
QMP>     "filename":"/export/target.qcow2"
QMP>   },
QMP>   "backing":{
QMP>     "driver":"qcow2",
QMP>     "file":{
QMP>       "driver":"file",
QMP>       "filename":"/export/base.qcow2"
QMP>     }
QMP>   }
QMP> }
{"error": {"class": "GenericError", "desc": "QMP input object member 'backing' is unexpected"}}
QMP> 

-- 
/kashyap
