Received: from eggs.gnu.org ([2001:4830:134:3::10]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHnaL-0003vl-PE
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHnaK-00028X-KK
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:09:45 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:33895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHnaK-00027V-DU
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:09:44 -0500
Received: by mail-it0-x242.google.com with SMTP id 75so1746338ite.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:09:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 16 Dec 2016 08:09:41 +0000
Message-ID: <CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Buddhi Madhav <Buddhi.Madhav@veritas.com>
Cc: ashish mittal <ashmit602@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Fri, Dec 16, 2016 at 1:42 AM, Buddhi Madhav
<Buddhi.Madhav@veritas.com> wrote:
>         Does this authentication scheme works?
>
> 1) Pass the encrypted password to qemu-kvm as follows:
>
> # . /qemu-io --object secret,id=secmaster0,format=base64,file=key.b64
>        --object secret,id=password-secret,keyid=secmaster0,file=pw.aes,iv=$(<iv.b64)
>
> 2) QEMU process will decrypt the password. (call qcrypto_secret_lookup_as_utf8()).

I'm not sure if AES encrypting the password secret file adds anything.
If an attacker is able to read pw.aes they can also read key.b64 and
see the initialization vector on the command-line (using ps(1)).
Therefore they would be able to decrypt the password.

The main benefit of using -object secret,file= is to limit access to
the secret via UNIX file permissions and to prevent exposing the
secret on the command-line.  You get those benefits without AES:

--object secret,id=password-secret,file=pw

Dan: Am I missing something?

> 3) For every disk open, QEMU process sends VM ID, vdisk ID, and decrypted password. Hyperscale server
>    validates the password, and sends back the access token(unique 32bit ID).

Two issues:

1. This is secure only if the transport offers confidentiality (e.g.
encryption over TCP).  Otherwise an attacker can intercept the traffic
and steal the decrypted password.

2. This is secure only if the client authenticates the server.
Otherwise the server could be a man-in-the-middle that steals the
password.

Your scheme is secure over AF_UNIX where the UNIX domain socket is
located in a directory where only the real server process has
permission to create files.  AF_UNIX cannot be intercepted by external
attackers or unprivileged users, so the transport offers
confidentiality.

This scheme is not secure over TCP/IP/Ethernet since the server is not
being authenticated and there is no confidentiality.

Are there network protocol and security folks at Veritas who can
advise you?  This isn't a QEMU-specific issue, it's a VxHS network
protocol issue.  You need to choose a modern, secure approach to
networking.

Stefan
