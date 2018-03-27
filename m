Received: from eggs.gnu.org ([2001:4830:134:3::10]:60232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0obF-00054q-9g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0obB-0002Wc-32
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:25:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1f0obA-0002Vo-Pq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:25:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RDOpLb113256
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:25:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gykv0sbub-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:24:58 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 07:24:34 -0600
Date: Tue, 27 Mar 2018 18:54:21 +0530
From: satheesh rajendran <sathnaga@linux.vnet.ibm.com>
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
	<20180327124000.GJ4005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180327124000.GJ4005@redhat.com>
Message-Id: <20180327132421.GA31240@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp.c: Revert hmp_info_cpus output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Tue, Mar 27, 2018 at 01:40:00PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Mar 27, 2018 at 06:08:00PM +0530, sathnaga@linux.vnet.ibm.com w=
rote:
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> >=20
> > This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> > refactors info cpus output and changes output format from
> > 'thread_id' to 'thread-id', this would break parsing
> > of output in above layers like libvirt, test framework etc.
>=20
> Libvirt doesn't use HMP, only QMP, so this shouldn't have broken libvir=
t
> afaik.  HMP is not intended to be a stable API so these kind of changes
> should be expected.

Am sure avocado test framework uses this output for parsing to extract th=
readid
and in libvirt atleast I checked below code uses it, I hope keeping the
format same as previous won't affect anything?

in src/qemu/qemu_monitor_text.c
int
qemuMonitorTextQueryCPUs(qemuMonitorPtr mon,
                         struct qemuMonitorQueryCpusEntry **entries,
                         size_t *nentries)
...
    if (qemuMonitorHMPCommand(mon, "info cpus", &qemucpus) < 0)
        return -1;

    /*
     * This is the gross format we're about to parse :-{
     *
     * (qemu) info cpus
     * * CPU #0: pc=3D0x00000000000f0c4a thread_id=3D30019
     *   CPU #1: pc=3D0x00000000fffffff0 thread_id=3D30020
     *   CPU #2: pc=3D0x00000000fffffff0 (halted) thread_id=3D30021
     *
     */
....
        /* Extract host Thread ID */
        if ((offset =3D strstr(line, "thread_id=3D")) =3D=3D NULL)

Regards,
-Satheesh
>=20
> >=20
> > This patch just reverts back output format to 'thread_id'.
> >=20
> > CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > ---
> >  hmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hmp.c b/hmp.c
> > index 679467d85a..a25c7bd9a8 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -381,7 +381,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdi=
ct)
> > =20
> >          monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> >                         cpu->value->cpu_index);
> > -        monitor_printf(mon, " thread-id=3D%" PRId64 "\n", cpu->value=
->thread_id);
> > +        monitor_printf(mon, " thread_id=3D%" PRId64 "\n", cpu->value=
->thread_id);
> >      }
> > =20
> >      qapi_free_CpuInfoFastList(cpu_list);
> > --=20
> > 2.14.3
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
