Received: from eggs.gnu.org ([2001:4830:134:3::10]:34276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eEybp-000258-36
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eEybk-0006Gu-HS
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:24:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eEybk-0006GW-7f
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:24:04 -0500
Date: Wed, 15 Nov 2017 14:23:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171115142352.GB2212@work-vm>
References: <6e0e65ef.427f.15faf8d41e9.Coremail.lichunguang@hust.edu.cn>
	<20171115101137.GA2212@work-vm>
	<2b8e8e.74dc.15fbfea1827.Coremail.lichunguang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b8e8e.74dc.15fbfea1827.Coremail.lichunguang@hust.edu.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Abnormal observation during migration: too many
 "write-not-dirty" pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chunguang Li <lichunguang@hust.edu.cn>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, stefanha@redhat.com

* Chunguang Li (lichunguang@hust.edu.cn) wrote:
>=20
>=20
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dr. David Alan Gilbert" <dgilbert@redha=
t.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2017-11-15 18:11:37 (=E6=98=9F=E6=
=9C=9F=E4=B8=89)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Chunguang Li" <lichunguang@hust.edu.cn>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org, quintela@redhat.com, amit.=
shah@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
> > =E4=B8=BB=E9=A2=98: Re: [Qemu-devel] Abnormal observation during migr=
ation: too many "write-not-dirty" pages
> >=20
> > * Chunguang Li (lichunguang@hust.edu.cn) wrote:
> > > Hi all!
> > >=20
> > > I got a very abnormal observation for the VM migration. I found tha=
t many pages marked as dirty during migration are "not really dirty", whi=
ch is, their content are the same as the old version.
> > >=20
> > >=20
> > >=20
> > >=20
> > > I did the migration experiment like this:
> > >=20
> > > During the setup phase of migration, first I suspended the VM. Then=
 I copied all the pages within the guest physical address space to a memo=
ry buffer as large as the guest memory size. After that, the dirty tracki=
ng began and I resumed the VM. Besides, at the end
> > > of each iteration, I also suspended the VM temporarily. During the =
suspension, I compared the content of all the pages marked as dirty in th=
is iteration byte-by-byte with their former copies inside the buffer. If =
the content of one page was the same as its former copy, I recorded it as=
 a "write-not-dirty" page (the page is written exactly with the same cont=
ent as the old version). Otherwise, I replaced this page in the buffer wi=
th the new content, for the possible comparison in the future. After the =
reset of the dirty bitmap, I resumed the VM. Thus, I obtain the proportio=
n of the write-not-dirty pages within all the pages marked as dirty for e=
ach pre-copy iteration.
> > >=20
> > > I repeated this experiment with 15 workloads, which are 11 CPU2006 =
benchmarks, Memcached server, kernel compilation, playing a video, and an=
 idle VM. The CPU2006 benchmarks and Memcached are write-intensive worklo=
ads. So almost all of them did not converge to stop-copy.
> > >=20
> > >=20
> > >=20
> > >=20
> > > Startlingly, the proportions of the write-not-dirty pages are quite=
 high. Memcached and three CPU2006 benchmarks(zeusmp, mcf and bzip2) have=
 the most high proportions. Their proportions of the write-not-dirty page=
s within all the dirty pages are as high as 45%-80%. The proportions of t=
he other workloads are about 5%-20%, which are also abnormal. According t=
o my intuition, the proportion of write-not-dirty pages should be far les=
s than these numbers. I think it should be quite a particular case that o=
ne page is written with exactly the same content as the former data.
> > >=20
> > > Besides, the zero pages are not counted for all the results. Becaus=
e I think codes like memset() may write large area of pages to zero pages=
, which are already zero pages before.
> > >=20
> > >=20
> > >=20
> > >=20
> > > I excluded some possible unknown reasons with the machine hardware,=
 because I repeated the experiments with two sets of different machines. =
Then I guessed it might be related with the huge page feature. However, t=
he result was the same when I turned the huge page feature off in the OS.
> > >=20
> > >=20
> > >=20
> > >=20
> > > Now there are only two possible reasons in my opinion.=20
> > >=20
> > > First, there is some bugs in the KVM kernel dirty tracking mechanis=
m. It may mark some pages that do not receive write request as dirty.
> > >=20
> > > Second, there is some bugs in the OS running inside the VM. It may =
issue some unnecessary write requests.
> > >=20
> > >=20
> > > What do you think about this abnormal phenomenon? Any advice or pos=
sible reasons or even guesses? I appreciate any responses, because it has=
 confused me for a long time. Thank you.
> >=20
> > Wasn't it you who pointed out last year the other possibility? - The
> > problem of false positives due to sync'ing the whole of memory and th=
en
> > writing the data out, but some of the dirty pages were already writte=
n?
> >=20
> > Dave
>=20
> Yes, you remember that!

Yes, I remember that, and my TODO list told me it was you :-)

> It was me. After that, I did more analysis and experiments. I found tha=
t, in fact, both reasons contribute to the "fake dirty" pages (dirty page=
s that do not need to be resent, because their contents are the same as t=
hat in the target node). One is what I pointed out last year, which you h=
ave mentioned. The other reason is what I am talking about now, the "writ=
e-not-dirty" phenomenon.
> In fact, according to my experiments results, the "wirte-not-dirty" is =
the main reason resulting to the "fake dirty" pages, while sync'ing the w=
hole of memory contributes less.

How do you differentiate between "fake dirty' and the syncing?

The cases where values change back to what they used to be seem
the most likely to me (e.g. locks/counts that decrement back) - but
that seems a high %.
I wonder if there's any difference between page write protection
based dirtying and PML (that I think can be used on some newer chips).

One way to debug it I guess would be to keep the write protection
and watch the progression of data values within a page - do they
actually change and then change back or do the values never
really change.

Dave


> Chunguang
> >=20
> > >=20
> > > --
> > > Chunguang Li, Ph.D. Candidate
> > > Wuhan National Laboratory for Optoelectronics (WNLO)
> > > Huazhong University of Science & Technology (HUST)
> > > Wuhan, Hubei Prov., China
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
