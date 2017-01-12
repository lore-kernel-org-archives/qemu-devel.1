Received: from eggs.gnu.org ([2001:4830:134:3::10]:56621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRVeH-0005ce-FF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRVeD-0000Ca-Jn
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:01:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cRVeD-0000CH-DS
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:01:53 -0500
Date: Thu, 12 Jan 2017 11:01:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170112030148.GC26504@lemon>
References: <20170111182455.15160-1-nirsof@gmail.com>
	<750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org

On Wed, 01/11 15:51, Eric Blake wrote:
> On 01/11/2017 12:24 PM, Nir Soffer wrote:
> > From: Nir Soffer <nsoffer@redhat.com>
> > 
> > The result of openfile was not checked, leading to failure deep in the
> > actual command with confusing error message, and exiting with exit code 0.
> > 
> > Here is one example - trying to read a pattern from an invalid chain:
> > 
> >     $ qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
> 
> As written, you have to guess some context about how top.qcow2 was
> created.  The example can be made a bit more reproducible with:
> 
> $ : > file
> $ qemu-io -f qcow2 -c ... file

Nir, thank you for the fix. Could you also add a regression test in
tests/qemu-iotests?

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> >     can't open device top.qcow2: Could not open backing file: Image is not in qcow2 format
> >     no file open, try 'help open'
> >     0
> > 
> > With this patch, we fail earlier with exit code 1:
> > 
> >     $ ./qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
> >     can't open device top.qcow2: Could not open backing file: Image is not
> >     in qcow2 format
> >     1
> > 
> > Signed-off-by: Nir Soffer <nirsof@gmail.com>
> > ---
> >  qemu-io.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Whether or not the commit message is improved,
> Reviewed-by: Eric Blake <eblake@redhat.com>
