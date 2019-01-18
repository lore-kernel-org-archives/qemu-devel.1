Received: from eggs.gnu.org ([209.51.188.92]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gkRps-00072z-Fp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gkRpp-0007A0-PS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:57:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gkRpp-000781-9n
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:57:13 -0500
Date: Fri, 18 Jan 2019 11:56:58 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190118105658.GB24176@beluga.usersys.redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<20190118101638.GE20660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118101638.GE20660@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] AMD SEV's /dev/sev permissions and
 probing QEMU for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, dinechin@redhat.com, mkletzan@redhat.com, brijesh.singh@amd.com, qemu-devel@nongnu.org

On Fri, Jan 18, 2019 at 10:16:38AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jan 18, 2019 at 10:39:35AM +0100, Erik Skultety wrote:
> > Hi,
> > this is a summary of a private discussion I've had with guys CC'd on =
this email
> > about finding a solution to [1] - basically, the default permissions =
on
> > /dev/sev (below) make it impossible to query for SEV platform capabil=
ities,
> > since by default we run QEMU as qemu:qemu when probing for capabiliti=
es. It's
> > worth noting is that this is only relevant to probing, since for a pr=
oper QEMU
> > VM we create a mount namespace for the process and chown all the node=
s (needs a
> > SEV fix though).
> >
> > # ll /dev/sev
> > crw-------. 1 root root
> >
> > I suggested either force running QEMU as root for probing (despite th=
e obvious
> > security implications) or using namespaces for probing too. Dan argue=
d that
> > this would have a significant perf impact and suggested we ask system=
d to add a
> > global udev rule.
>
> I've just realized there is a potential 3rd solution. Remember there is
> actually nothing inherantly special about the 'root' user as an account
> ID. 'root' gains its powers from the fact that it has many capabilities
> by default.  'qemu' can't access /dev/sev because it is owned by a
> different user (happens to be root) and 'qemu' does not have capabiliti=
es.
>
> So we can make probing work by using our capabilities code to grant
> CAP_DAC_OVERRIDE to the qemu process we spawn. So probing still runs
> as 'qemu', but can none the less access /dev/sev while it is owned
> by root.  We were not using 'qemu' for sake of security, as the probing
> process is not executing any untrusthworthy code, so we don't  loose an=
y
> security protection by granting CAP_DAC_OVERRIDE.

Truth to be told, I was playing with the idea of using CAP_ capabilities,
however, because I'm paranoid (maybe too much) I took your comment "malic=
ious
QEMU" as an axiom for the process not be trusted *at all*, regardless of =
what
it's doing, I decided to ditch the idea, because with CAP_DAC_OVERRIDE, y=
ou're
essentially giving QEMU an open ticket to any file on the filesystem (oka=
y, not
any and not always because QEMU executed by system libvirt will be confin=
ed so
SElinux will still be our guardian angel).

[...]

> >
> > So, in conclusion, we absolutely need input from Brijesh (AMD) whethe=
r there
> > was something more than the low limit on number of guests behind the =
default
> > permissions. Also, we'd like to get some details on how the limit is =
managed,
> > helping to assess the approaches mentioned above.
>
> Regardless of this problem, I think it is important to have some docs
> in either libvirt or QEMU that describe the resource usage constraints
> so that management apps can decide how to best take advantage of SEV.

Agreed. In the meantime, I'll start working on adding /dev/sev into the
namespace only for SEV-enabled guests.

Thanks,
Erik
