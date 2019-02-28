Received: from eggs.gnu.org ([209.51.188.92]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzJC3-0001gL-Rp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzJC3-0001C1-0a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:45:35 -0500
Received: from mail-it1-x132.google.com ([2607:f8b0:4864:20::132]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llyzs.vic@gmail.com>) id 1gzJC2-0001B5-O6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:45:34 -0500
Received: by mail-it1-x132.google.com with SMTP id 188so14969895itb.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 02:45:34 -0800 (PST)
MIME-Version: 1.0
From: llyzs <llyzs.vic@gmail.com>
Date: Thu, 28 Feb 2019 18:45:22 +0800
Message-ID: <CACxphuH+U=C1bUASDKTqg+AiwQLV9ARJ3DHYSE97Uw9d=bM_VA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005ef8760582f1fde9"
Subject: [Qemu-devel] sorecvfrom freezes guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

--0000000000005ef8760582f1fde9
Content-Type: text/plain; charset="UTF-8"

Hi,

I am having a guest freeze issue (win10), and through debugging I found out
that sometimes sorecvfrom() is called from slirp.c because revents ==
G_IO_IN, however inside sorecvfrom() function, ioctlsocket() returns 0
bytes available and recvfrom could be blocking indefinitely. I am not sure
the root cause of the situation, but I added a non-blocking check to
recvfrom and it fixed my issue. My patch is as attached. Please check if
this is a right fix.

--0000000000005ef8760582f1fde9
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-socket-fix-blocking-udp-recvfrom.patch"
Content-Disposition: attachment;
	filename="0001-socket-fix-blocking-udp-recvfrom.patch"
Content-Transfer-Encoding: base64
Content-ID: <16933b427891f7d22c81>
X-Attachment-Id: 16933b427891f7d22c81

RnJvbSAxMWRmYTM0MDJlYWNhYzlhMDVmMTI5MzRmZDMyMmYzN2M4ZTBjZTM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWMgTGVlIDxsbHl6cy52aWNAZ21haWwuY29tPgpEYXRlOiBU
aHUsIDI4IEZlYiAyMDE5IDE4OjIzOjI0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gc29ja2V0OiBm
aXggYmxvY2tpbmcgdWRwIHJlY3Zmcm9tLgoKLS0tCiBzbGlycC9zb2NrZXQuYyB8IDQgKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3NsaXJwL3NvY2tldC5jIGIvc2xpcnAvc29ja2V0LmMKaW5kZXggYzAxZDg2OTZhZi4uZWEz
MDQ3OGNlNiAxMDA2NDQKLS0tIGEvc2xpcnAvc29ja2V0LmMKKysrIGIvc2xpcnAvc29ja2V0LmMK
QEAgLTU4MSw3ICs1ODEsNyBAQCBzb3JlY3Zmcm9tKHN0cnVjdCBzb2NrZXQgKnNvKQogCSAgfQog
CSAgLyogfSAqLwogCi0JICBtLT5tX2xlbiA9IHJlY3Zmcm9tKHNvLT5zLCBtLT5tX2RhdGEsIGxl
biwgMCwKKwkgIG0tPm1fbGVuID0gcmVjdmZyb20oc28tPnMsIG0tPm1fZGF0YSwgbGVuLCBNU0df
RE9OVFdBSVQsCiAJCQkgICAgICAoc3RydWN0IHNvY2thZGRyICopJmFkZHIsICZhZGRybGVuKTsK
IAkgIERFQlVHX01JU0MoKGRmZCwgIiBkaWQgcmVjdmZyb20gJWQsIGVycm5vID0gJWQtJXNcbiIs
CiAJCSAgICAgIG0tPm1fbGVuLCBlcnJubyxzdHJlcnJvcihlcnJubykpKTsKQEAgLTYxOCw2ICs2
MTgsOCBAQCBzb3JlY3Zmcm9tKHN0cnVjdCBzb2NrZXQgKnNvKQogCSAgICAgIGJyZWFrOwogCSAg
ICB9CiAJICAgIG1fZnJlZShtKTsKKwkgIH0gZWxzZSBpZiAobS0+bV9sZW49PTApIHsKKwkgICAg
bV9mcmVlKG0pOwogCSAgfSBlbHNlIHsKIAkgIC8qCiAJICAgKiBIYWNrOiBkb21haW4gbmFtZSBs
b29rdXAgd2lsbCBiZSB1c2VkIHRoZSBtb3N0IGZvciBVRFAsCi0tIAoyLjIwLjEKCg==
--0000000000005ef8760582f1fde9--
