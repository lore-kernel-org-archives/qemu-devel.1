Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1da5kq-0001O1-7H
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1da5km-00020F-Af
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1da5km-0001zb-27
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 102CD710A8
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:44:23 +0000 (UTC)
Date: Tue, 25 Jul 2017 21:43:57 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170725194357.nz2svyvw3dnh4jxc@localhost.localdomain>
References: <20170721095553.10717-1-jfreimann@redhat.com>
	<20170721095553.10717-5-jfreimann@redhat.com>
	<20170724134243.GE2784@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170724134243.GE2784@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 4/4] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

On Mon, Jul 24, 2017 at 02:42:43PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jul 21, 2017 at 11:55:53AM +0200, Jens Freimann wrote:
>> +static const char *init_hugepagefs(const char *path)
>> +{
>> +    struct statfs fs;
>> +    int ret;
>> +
>> +    if (access(path, R_OK | W_OK | X_OK)) {
>> +        g_test_message("access on path (%s): %s\n", path, strerror(errno));
>> +        return NULL;
>> +    }
>> +
>> +    do {
>> +        ret = statfs(path, &fs);
>
>This system-call and HUGETLBFS_MAGIC are Linux-specific but I don't see
>anything in the makefile or this test code that restricts it to Linux.
>Will this break non-Linux hosts?
>
>Perhaps #ifdef __linux__ is needed.

Yes, I think so. I might get rid of it init_hugepagefs altogether
though. 

>
>> +    } while (ret != 0 && errno == EINTR);
>> +
>> +    if (ret != 0) {
>> +        g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
>> +        return NULL;
>> +    }
>> +
>> +    if (fs.f_type != HUGETLBFS_MAGIC) {
>> +        g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
>> +        return NULL;
>> +    }
>> +
>> +    return path;
>> +}
>> +
>> +static int vubr_create_socket(struct sockaddr_in *si_remote, int rport)
>> +{
>> +    int sock;
>> +
>> +    if (inet_aton("127.0.0.1", (struct in_addr *) &si_remote->sin_addr.s_addr)
>> +            == 0) {
>> +        g_test_message("inet_aton failed\n");
>> +        return -1;
>> +    }
>
>Or:
>
>  si_remote->sin_addr.s_addr = htonl(INADDR_LOOPBACK);

Yes, I'll change it. 

>> +    sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
>> +    if (sock == -1) {
>> +        g_test_message("socket creation failed\n");
>> +        return -1;
>> +    }
>> +    if (connect(sock, (struct sockaddr *) si_remote, sizeof(*si_remote))) {
>> +        g_test_message("connect failed: %s", strerror(errno));
>> +        return -1;
>> +    }
>> +
>> +    return sock;
>> +}
>> +
>> +static void test_pxe_vhost_user(void)
>> +{
>> +    char template[] = "/tmp/vhost-user-bridge-XXXXXX";
>> +    char template2[] = "/tmp/hugepages-XXXXXX";
>> +    gchar * vubr_args[] = {NULL, NULL, NULL, NULL};
>> +    struct sockaddr_in si_remote = {
>> +        .sin_family = AF_INET,
>> +        .sin_port = htons(RPORT),
>> +    };
>> +    const char *hugefs = NULL;
>> +    const char *tmpfs2 = NULL;
>> +    const char *tmpfs = NULL;
>> +    const char *root = NULL;
>> +    GError *error = NULL;
>> +    char *vubr_binary;
>> +    char *qemu_args;
>> +    GPid vubr_pid;
>> +    int sock = -1;
>> +
>> +    tmpfs = mkdtemp(template);
>> +    if (!tmpfs) {
>> +        g_test_message("mkdtemp on path(%s): %s\n",
>> +                       template, strerror(errno));
>> +    }
>> +    vubr_binary = getenv("QTEST_VUBR_BINARY");
>> +    g_assert(vubr_binary);
>> +    vubr_args[0] = g_strdup_printf("%s", vubr_binary);
>> +    vubr_args[1] = g_strdup_printf("-u");
>> +    vubr_args[2] = g_strdup_printf("%s/%s", tmpfs, VUBR_SOCK);
>> +    g_spawn_async(NULL, vubr_args, NULL,
>> +                  G_SPAWN_SEARCH_PATH_FROM_ENVP |
>> +                  G_SPAWN_SEARCH_PATH,
>> +                  NULL, NULL, &vubr_pid, &error);
>
>I think a few things are missing for test cleanup (especially on
>failure).
>
>From https://developer.gnome.org/glib/stable/glib-Spawning-Processes.html#g-spawn-async-with-pipes:
>
>  If child_pid is not NULL and an error does not occur then the returned
>  process reference must be closed using g_spawn_close_pid().
>
>G_SPAWN_DO_NOT_REAP_CHILD wasn't specified so glib will automatically
>reap the child but the test case will not know when the vubr process has
>terminated.
>
>A qtest_add_abrt_handler() is also missing to kill the vubr child if the
>test case terminates.

I'll add an abort handler and make sure that the vubr process is
terminated. 

Thanks for the review!

regards,
Jens 
