Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxsyp-0005oq-Dy
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dxsym-0007s8-2k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:57:15 -0400
Date: Fri, 29 Sep 2017 12:57:01 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170929105701.GA22364@vader>
References: <20170821155005.16885-1-otubo@redhat.com>
	<45e8e004-5a55-07a3-190b-c01106af5de4@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45e8e004-5a55-07a3-190b-c01106af5de4@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] filter-mirror: segfault
 when specifying non existent device
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu-trivial@nongnu.org, lizhijian@cn.fujitsu.com, mjt@tls.msk.ru, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Tue, Aug 22, 2017 at 09:19:20AM +0800, Zhang Chen wrote:
> 
> 
> On 08/21/2017 11:50 PM, Eduardo Otubo wrote:
> > When using filter-mirror like the example below where the interface
> > 'ndev0' does not exist on the host, QEMU crashes into segmentation
> > fault.
> > 
> >   $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0
> > 
> > This happens because the function filter_mirror_setup() does not checks
> > if the device actually exists and still keep on processing calling
> > qemu_chr_find(). This patch fixes this issue.
> > 
> > Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> 
> Looks good for me.
> 
> Reviewed-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>
> 
> Thanks
> Zhang Chen
> 

So Peter and Michael pointed that this patch didn't pass on make check causing
this:

qemu-system-x86_64: -object
filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0: Device
'qtest-bn0' not found                                                                                                                   
Broken pipe                                                
GTester: last random seed: R02S4f1b7fb2da540e3e36e962f19f19ac65                                                        

(tests/test-filter-mirror:6059): GLib-CRITICAL **: g_hook_destroy_link:
assertion 'hook != NULL' failed                
make: *** [/home/otubo/develop/qemu/otubo/tests/Makefile.include:847:
check-qtest-x86_64] Error 1                      
otubo@vader ~/develop/qemu/otubo netdev_segfault $ git show

> > ---
> >   net/filter-mirror.c | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > index 90e2c92337..e18a4b16a0 100644
> > --- a/net/filter-mirror.c
> > +++ b/net/filter-mirror.c
> > @@ -213,14 +213,22 @@ static void filter_mirror_setup(NetFilterState *nf, Error **errp)
> >       MirrorState *s = FILTER_MIRROR(nf);
> >       Chardev *chr;
> > +    if (s->outdev == NULL) {
> > +        goto err;
> > +    }
> > +
> >       chr = qemu_chr_find(s->outdev);
> > +
> >       if (chr == NULL) {
> > -        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > -                  "Device '%s' not found", s->outdev);
> > -        return;
> > +        goto err;
> >       }
> >       qemu_chr_fe_init(&s->chr_out, chr, errp);

And the reason was there was no return after qemu_chr_fe_init, making it fatally
go to the "err:" label.

> > +
> > +err:
> > +    error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Device '%s' not found",
> > +              nf->netdev_id);

Also, "nf->netdev_id" wasn't the device not found, but "s->outdev"; which makes
sense to have two error messages here one for when Null and one for when it's
not found, otherwise we'd fall into not very clear error messages like:

qemu-system-x86_64: -object filter-mirror,id=test-object,netdev=ndev0: Device
'(null)' not found

I'm fixing all this and sending a v2 shortly.
Thanks for the review and tests.

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
