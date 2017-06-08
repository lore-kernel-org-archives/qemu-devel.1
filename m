Received: from eggs.gnu.org ([2001:4830:134:3::10]:58207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIlvZ-0001WN-6s
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIlvU-0004S7-6T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:07:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:1920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dIlvT-0004Rv-SC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:07:52 -0400
Date: Thu, 8 Jun 2017 09:07:48 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170608010748.jqcdbcnt44pvqjsr@hz-desktop>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-3-haozhong.zhang@intel.com>
	<20170607151445.GE21990@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607151445.GE21990@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] nvdimm: warn if the backend is not
 a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 06/07/17 16:14 +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 06, 2017 at 03:22:27PM +0800, Haozhong Zhang wrote:
> > diff --git a/util/osdep.c b/util/osdep.c
> > index a2863c8e53..02881f96bc 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -471,3 +471,64 @@ writev(int fd, const struct iovec *iov, int iov_cnt)
> >      return readv_writev(fd, iov, iov_cnt, true);
> >  }
> >  #endif
> > +
> > +#ifdef __linux__
> > +static ssize_t qemu_dev_dax_sysfs_read(int fd, const char *entry,
> > +                                       char *buf, size_t len)
> > +{
> > +    ssize_t read_bytes;
> > +    struct stat st;
> > +    unsigned int major, minor;
> > +    char *path, *pos;
> > +    int sysfs_fd;
> > +
> > +    if (fstat(fd, &st)) {
> > +        return 0;
> > +    }
> > +
> > +    major = major(st.st_rdev);
> > +    minor = minor(st.st_rdev);
> > +    path = g_strdup_printf("/sys/dev/char/%u:%u/%s", major, minor, entry);
> > +
> > +    sysfs_fd = open(path, O_RDONLY);
> > +    g_free(path);
> > +    if (sysfs_fd == -1) {
> > +        return 0;
> > +    }
> > +
> > +    read_bytes = read(sysfs_fd, buf, len - 1);
> > +    close(sysfs_fd);
> > +    if (read_bytes > 0) {
> > +        buf[read_bytes] = '\0';
> > +        pos = g_strstr_len(buf, read_bytes, "\n");
> > +        if (pos) {
> > +            *pos = '\0';
> > +        }
> 
> Should read_bytes be adjusted since we made the string shorter?

Yes, I'll change in the next version.

Thanks,
Haozhong
