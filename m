Received: from eggs.gnu.org ([2001:4830:134:3::10]:52502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eBQ9U-00078D-VJ
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eBQ9P-00039y-Rg
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1eBQ9P-00039X-Ky
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 14:00:07 -0500
Date: Sun, 5 Nov 2017 19:59:59 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171105185959.fi5xvniqicg7rtiq@eukaryote>
References: <1476435656-3100-1-git-send-email-stefanha@redhat.com>
	<1476435656-3100-4-git-send-email-stefanha@redhat.com>
	<f142a70a-dd03-76e3-52a7-79277c51928a@redhat.com>
	<20161016133526.GA13844@stefanha-x1.localdomain>
	<bb54ed67-1839-4527-13e1-45009b6d4adf@redhat.com>
	<20161018102123.GF19457@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161018102123.GF19457@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] sockets: add AF_VSOCK support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

[Reviving a more than 1-year old thread.  I randomly noticed this (refer
below) while browsing through AF_VSOCK changes in my 'qemu-devel'
maildir.]

On Tue, Oct 18, 2016 at 11:21:23AM +0100, Stefan Hajnoczi wrote:
> On Mon, Oct 17, 2016 at 09:25:46AM -0500, Eric Blake wrote:
> > On 10/16/2016 08:35 AM, Stefan Hajnoczi wrote:
> > 
> > >>> +
> > >>> +    if (sscanf(str, "%32[^:]:%32[^,]%n", cid, port, &n) != 2) {
> > >>
> > >> This says stop at the first comma after the colon...
> > >>
> > >>> +        error_setg(errp, "error parsing address '%s'", str);
> > >>> +        return NULL;
> > >>> +    }
> > >>> +    if (str[n] != '\0') {
> > >>> +        error_setg(errp, "trailing characters in address '%s'", str);
> > >>
> > >> ...but this rejects a trailing comma.  Is a trailing comma possible base
> > >> on how QemuOpts work? If so, do you need to handle it here?
> > > 
> > > Actually I just wanted to grab characters up until the end of string.
> > > It wasn't clear from the sscanf(3) man page what the best way to do that
> > > was, so I kept the comma which is also used in tcp addresses (because
> > > they support additional comma-separated options).
> > 
> > %32s instead of %32[^,] should grab up to all 32 remaining characters in
> > the string; your %n trick then ensures there is no garbage.  I guess
> > it's still a question of whether we want to always treat a comma as
> > trailing garbage.
> 
> No comma options are currently accepted.  Treating comma as garbage
> seems okay.
> 
> Mike: Please change %32[^,] to %32s when merging.  Thanks!

The above change didn't take place while merging at that time as part of
v2.7.0-1720-g6a02c80.

I still see %32[^,] in all the sscanf(3) calls in
util/util/qemu-sockets.c

Is it still important to change?

-- 
/kashyap
