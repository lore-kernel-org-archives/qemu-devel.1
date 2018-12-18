Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6oF-0004Bg-Sd
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6bK-00051c-IB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:03:23 -0500
Date: Mon, 17 Dec 2018 23:03:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217224807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] sheepdog build warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, meyering@redhat.com, Kevin Wolf <kwolf@redhat.com>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, peter.maydell@linaro.org

mingw32 build on fedora fails with this warning:

/scm/qemu/block/sheepdog.c: In function 'find_vdi_name':
/scm/qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/scm/qemu/rules.mak:69: block/sheepdog.o] Error 1
make: *** Waiting for unfinished jobs....


Reading the code one sees it's working as intended:


static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
                         uint32_t snapid, const char *tag, uint32_t *vid,
                         bool lock, Error **errp)
{
    int ret, fd;
    SheepdogVdiReq hdr;
    SheepdogVdiRsp *rsp = (SheepdogVdiRsp *)&hdr;
    unsigned int wlen, rlen = 0;
    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];

    fd = connect_to_sdog(s, errp);
    if (fd < 0) {
        return fd;
    }

    /* This pair of strncpy calls ensures that the buffer is zero-filled,
     * which is desirable since we'll soon be sending those bytes, and
     * don't want the send_req to read uninitialized data.
     */
    strncpy(buf, filename, SD_MAX_VDI_LEN);
    strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);


.....

}



so this seems to be the case of GCC developers deciding that
strncpy is simply a bad API and a correct use of it should be
warned against.

I propose either

1. simply adding

#pragma GCC diagnostic ignored "-Wstringop-truncation"

in osdep.

2. adding an inline wrapper with said pragma in there.

3. -Wno-stringop-truncation is the makefile

Thoughts?

-- 
MST
