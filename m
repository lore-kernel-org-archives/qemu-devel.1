Received: from eggs.gnu.org ([209.51.188.92]:38709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gilYO-0007Ft-IU
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gilYN-0003Uh-I6
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:36:16 -0500
Date: Sun, 13 Jan 2019 21:36:03 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190113193603.GA10282@lap1>
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
	<20190112150225.20294-3-marcel.apfelbaum@gmail.com>
	<20190113192439.GB10017@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113192439.GB10017@lap1>
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/rdma: modify struct initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Sun, Jan 13, 2019 at 09:24:40PM +0200, Yuval Shaia wrote:
> On Sat, Jan 12, 2019 at 05:02:24PM +0200, Marcel Apfelbaum wrote:
> > Do not initialize structs with {0} since some
> > CLANG versions do not support it.
> > 
> > Use memset instead.
> 
> It is easier than patching CLANG ha? :)
> 
> > 
> > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > ---
> >  contrib/rdmacm-mux/main.c | 12 +++++++++---
> >  hw/rdma/rdma_backend.c    | 16 ++++++++++++----
> >  2 files changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
> > index 64676030c5..d01dc76927 100644
> > --- a/contrib/rdmacm-mux/main.c
> > +++ b/contrib/rdmacm-mux/main.c
> > @@ -350,9 +350,11 @@ static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
> >  static void *umad_recv_thread_func(void *args)
> >  {
> >      int rc;
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      int fd = -2;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_REQ;
> >      msg.hdr.op_code = RDMACM_MUX_OP_CODE_MAD;
> >  
> > @@ -387,11 +389,13 @@ static void *umad_recv_thread_func(void *args)
> >  static int read_and_process(int fd)
> >  {
> >      int rc;
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      struct umad_hdr *hdr;
> >      uint32_t *comm_id = 0;
> >      uint16_t attr_id;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      rc = recv(fd, &msg, sizeof(msg), 0);
> >      syslog(LOG_DEBUG, "Socket %d, recv %d\n", fd, rc);
> >  
> > @@ -744,7 +748,9 @@ static void signal_handler(int sig, siginfo_t *siginfo, void *context)
> >  static int init(void)
> >  {
> >      int rc;
> > -    struct sigaction sig = {0};
> > +    struct sigaction sig;
> > +
> > +    memset(&sig, 0, sizeof(sig));
> >  
> >      rc = init_listener();
> >      if (rc) {
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index c28bfbd44d..92e95aa640 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -190,9 +190,11 @@ static inline int rdmacm_mux_can_process_async(RdmaBackendDev *backend_dev)
> >  
> >  static int check_mux_op_status(CharBackend *mad_chr_be)
> >  {
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      int ret;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      pr_dbg("Reading response\n");
> >      ret = qemu_chr_fe_read_all(mad_chr_be, (uint8_t *)&msg, sizeof(msg));
> >      if (ret != sizeof(msg)) {
> > @@ -387,10 +389,12 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> >  static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
> >                      union ibv_gid *sgid, struct ibv_sge *sge, uint32_t num_sge)
> >  {
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      char *hdr, *data;
> >      int ret;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      pr_dbg("num_sge=%d\n", num_sge);
> >  
> >      if (num_sge != 2) {
> > @@ -1112,9 +1116,11 @@ int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
> >  int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
> >                           union ibv_gid *gid)
> >  {
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      int ret;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      pr_dbg("0x%llx, 0x%llx\n",
> >             (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
> >             (long long unsigned int)be64_to_cpu(gid->global.interface_id));
> > @@ -1138,9 +1144,11 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
> >  int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
> >                           union ibv_gid *gid)
> >  {
> > -    RdmaCmMuxMsg msg = {0};
> > +    RdmaCmMuxMsg msg;
> >      int ret;
> >  
> > +    memset(&msg, 0, sizeof(msg));
> > +
> >      pr_dbg("0x%llx, 0x%llx\n",
> >             (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
> >             (long long unsigned int)be64_to_cpu(gid->global.interface_id));
> 
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> 
> One comment though, should subject prefixed with hw/rdma or
> contrib/rdmacm-mux?

Just noticed that patch took care of both so would it be better to have two
separate patches instead?

> 
> > -- 
> > 2.17.1
> > 
> 
