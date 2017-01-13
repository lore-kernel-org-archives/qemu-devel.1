Received: from eggs.gnu.org ([2001:4830:134:3::10]:55923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cS5b5-0006i7-Aq
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cS5b2-0007Bc-62
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:25:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cS5b1-0007Ac-Tg
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:25:00 -0500
Date: Fri, 13 Jan 2017 12:45:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170113144520.GW3565@thinpad.lan.raisama.net>
References: <1484237891-30525-1-git-send-email-walling@linux.vnet.ibm.com>
	<20170113100421.GF4107100@orkuz.home>
	<668355dc-c747-f9a0-859d-054e9bfd80f0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668355dc-c747-f9a0-859d-054e9bfd80f0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-capabilities: Fix
 query-cpu-model-expansion on s390 with older kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: "Collin L. Walling" <walling@linux.vnet.ibm.com>, libvir-list@redhat.com, alifm@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Fri, Jan 13, 2017 at 09:06:52AM -0500, Jason J. Herne wrote:
> On 01/13/2017 05:04 AM, Jiri Denemark wrote:
> > On Thu, Jan 12, 2017 at 11:18:11 -0500, Collin L. Walling wrote:
> > > When running on s390 with a kernel that does not support cpu model checking and
> > > with a Qemu new enough to support query-cpu-model-expansion, the gathering of qemu
> > > capabilities will fail. Qemu responds to the query-cpu-model-expansion qmp
> > > command with an error because the needed kernel ioct does not exist. When this
> > > happens a guest cannot even be defined due to missing qemu capabilities data.
> > > 
> > > This patch fixes the problem by silently ignoring generic errors stemming from
> > > calls to query-cpu-model-expansion.
> > > 
> > > Reported-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > > Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> > > Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> > > ---
> > >  src/qemu/qemu_monitor_json.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/src/qemu/qemu_monitor_json.c b/src/qemu/qemu_monitor_json.c
> > > index e767437..1662749 100644
> > > --- a/src/qemu/qemu_monitor_json.c
> > > +++ b/src/qemu/qemu_monitor_json.c
> > > @@ -5041,6 +5041,15 @@ qemuMonitorJSONGetCPUModelExpansion(qemuMonitorPtr mon,
> > >      if (qemuMonitorJSONCommand(mon, cmd, &reply) < 0)
> > >          goto cleanup;
> > > 
> > > +    /* Some QEMU architectures have the query-cpu-model-expansion
> > > +     * command, but return 'GenericError' instead of simply omitting
> > > +     * the command entirely.
> > > +     */
> > 
> > Hmm, this comment says something a bit different than the commit
> > message. I hope the issue described by this comment was fixed in QEMU
> > within the same release the query-cpu-model-expansion command was
> > introduced. But we need to fix this nevertheless to address what the
> > commit message describes.
> > 
> 
> The issue still exists in Qemu. I can work up a patch to handle it. My first
> idea is to simply test that the ioctl exists and functions at Qemu
> initialization and deregister the query-cpu-model-expansion command in the
> event that the ioctl does not exist or fails. Thoughts?

I'm not sure, probably unregistering the command after KVM is
initialized is too late. Even if today QMP is available only
after the accelerator is already initialized, we might want to
delay accelerator initialization in the future (so the
accelerator could be configured using QMP commands).

Also, I'm not sure when/how exactly the query-cpu-model-expansion
call fails. If the ioctl isn't available, shouldn't
query-cpu-model-expansion fail only when querying "host", but let
the other CPU models to be queried? In this case, unregistering
the command doesn't seem to be the right solution. Probably
omitting "host" (or flagging it as unavailable?) on
query-cpu-model-definitions would be better.

-- 
Eduardo
