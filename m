Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F9921655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB8inZlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F9921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUC8Z-0006qt-2h
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iUC6s-0005cY-F3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iUC6l-00016a-DU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iUC6l-00014G-5C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MxnAxRLrQX7/QwSfBoeaZzOZRH/LaCEp1hWn8NFAwAc=;
 b=KB8inZlW3DVo1cJhrLROPKHlLcNrLCEpDuXr5JIzIeDm/8N1rkKve2QWTIl+dNBNsyMr2j
 2ZOnL0fPPm2ybKNd9F9oQ76N1KzQBMivRa0OTW2we4uWkSHEwFHw03xbmTbQtYAHNuCHAb
 vyTCcMO0cyw/1mv5JyyVt7WBEf34MgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-a5FcpH9yMkaLlJ7LqhObVw-1; Mon, 11 Nov 2019 10:58:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F03A1005500;
 Mon, 11 Nov 2019 15:58:35 +0000 (UTC)
Received: from dhcp-4-209.tlv.redhat.com (dhcp-4-209.tlv.redhat.com
 [10.35.4.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68D0D28D28;
 Mon, 11 Nov 2019 15:58:21 +0000 (UTC)
Message-ID: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
Subject: API definition for LUKS key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 11 Nov 2019 17:58:20 +0200
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: a5FcpH9yMkaLlJ7LqhObVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Ferlan <jferlan@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I would like to discuss the API for LUKS key management.

First of all very brief overview of LUKS v1 format:

Each sector of the image is encrypted with same master key, which
is not stored directly on the disk.

Instead in the LUKS header we have 8 slots. Each slot optionally stores
an encrypted version of the master key, encrypted by the user password.
Knowing the password, you can retrieve the master key from the keyslot.
Slot can be marked as active or inactive, inactive slots are not considered
when opening the image.

In addition to that LUKS header has a hash of the master key, so that
you can check if the password 'opens' a keyslot by decrypting it
with given the password, and then checking if=20
the hash of the decrypted master key candidate obtained matches the stored =
hash.

That basically means that you can have up to 8 different passwords that wil=
l
open a luks volume and you can change them as you wish without re-encryptin=
g
everything.

Now for raw luks volumes you have cryptsetup which allows to manage these
keyslots, but we also have so called encrypted qcow2 format which
basically has the luks header, together with keyslots embedded, plus each
cluster is encrypted with the master key as in raw luks.
Cryptsetup doesn't support this, thus I implemented this in qemu block laye=
r.

Link to bugzilla here: https://bugzilla.redhat.com/show_bug.cgi?id=3D166241=
2


Relevant to the API,
first of all qemu has the notion of amend (qemu-img amend), which allows
currently to change format specific extensions of qcow2.

Since luks, especially luks inside qcow2 is a format on its own, it fits to=
=20
use that interface to change the 'format' options, in this case,
the encryption key slots.


There are the following requirements (they are 100% hardcoded, we might dis=
cuss
to drop some of these):


1. ability to add a new password to a free keyslot=20
(best is to let api to pick a free keyslot)
Also user should not need to know all the passwords in existing keyslots.


2. ability to erase a keyslot, usually by giving the password that should b=
e erased, and erasing all
the keyslots that match the password, or by giving a keyslot index.
This will usually be done after adding a new password.


3. Allow to do so online, that is while qemu is running, but also support o=
ffline management.
Note that online management is even useful for raw luks volumes, since its =
not safe
to run cryptsetup on them while qemu is using the images.


I implemented those requirements using the following interface.
(I have sent the patches already)

I will try to explain the interface with bunch of examples:


# adds a new password, defined by qemu secret 'sec0' to first unused slot
# give user a error if all keyslots are occupied
qemu-img amend --secret ... -o key-secret=3Dsec1 image.luks


# erases all keyslots that can be opened by password that is contained in a=
 qemu secret 'sec0'
# active=3Doff means that the given password/keyslot won't be active after =
the operation
qemu-img amend --secret ... -o key-secret=3Dsec0,active=3Doff image.luks


# erase the slot 5 (this is more low level command, less expected to be use=
d)
qemu-img amend --secret ... -o slot=3D5,active=3Doff image.luks

# add new secret to slot 5 (will fail if the slot is already marked as acti=
ve)
qemu-img amend --secret ... -o slot=3D5,key-secret=3Dsec1 image.luks


This is basically it.

The full option syntax is as following:

active=3Don/off (optional, default to on) - toggles if we enabling a keyslo=
t or are erasing it.

slot=3Dnumber (optional, advanced option) - specifies which exactly slot to=
 erase or which
slot to put the new key on

key-secret =3D id of the secret object - specifies the secret. when slot is=
 enabled,
it will be put into the new slot. when disabling (erasing a keyslot), all k=
eyslots
matching that secret will be erased.=20
Specifying both key-secret and slot index is treated as error I think


As as very advanced option, --force is added to qemu-img to allow to do uns=
afe operation,
which in this case is removing last keyslot which will render the encrypted=
 image useless.


In addition to that, QMP interface was added for online version of the abov=
e.
It is very similiar, but since we don't have blockdev-amend,
I added one and it has the following interface:



##
# @x-blockdev-amend:
#
# Starts a job to amend format specific options of an existing open block d=
evice.
# The job is automatically finalized, but a manual job-dismiss is required.
#
# @job-id:          Identifier for the newly created job.
#
# @node-name:       Name of the block node to work on
#
# @options:         Options (same as for image creation)
#
# @force:           Allow unsafe operations, format specific
#                   For luks that allows erase of the last active keyslot
#                   (permanent loss of data),
#                   and replacement of an active keyslot
#                   (possible loss of data if IO error happens)
#
# Since: 4.2
##
{ 'command': 'x-blockdev-amend',
  'data': { 'job-id': 'str',
            'node-name': 'str',
            'options': 'BlockdevCreateOptions',
            '*force': 'bool' } }



It takes the same BlockdevCreateOptions as blockdev-create (this is open to=
 debate if to leave this as is)


BlockdevCreateOptionsLUKS (its parent QCryptoBlockCreateOptionsLUKS technic=
ally is extended in this way):


--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -190,6 +190,21 @@
 #                  Currently defaults to 'sha256'
 # @hash-alg: the master key hash algorithm
 #            Currently defaults to 'sha256'
+#
+# @active: Should the new secret be added (true) or erased (false)
+#          (amend only, since 4.2)
+#
+# @slot: The slot in which to put/erase the secret
+#        if not given, will select first free slot for secret addtion
+#        and erase all keyslots that match the given @key-secret for erase=
.
+#        except the last one
+#        (optional, since 4.2)
+#
+# @unlock-secret: The secret to use to unlock the image
+#        If not given, will use the secret that was used
+#        when opening the image.
+#        (optional, for amend only, since 4.2)
+#
 # @iter-time: number of milliseconds to spend in
 #             PBKDF passphrase processing. Currently defaults
 #             to 2000. (since 2.8)
@@ -201,7 +216,12 @@
             '*cipher-mode': 'QCryptoCipherMode',
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
+
             '*hash-alg': 'QCryptoHashAlgorithm',
+            '*active' : 'bool',
+            '*slot': 'int',
+            '*unlock-secret': 'str',
+
             '*iter-time': 'int'}}


Here note that key-secret is already present in the in api, and I am adding=
 the 'slot','active' and 'unlock-secret'

'slot' can be also used for new created image to specify where to place the=
 the secret.
'active' not allowed to be false for blockdev-create of an image and can be=
 true/false for 'blockdev-amend'

'unlock-secret' (might be removed later) covers an corner case that is spec=
ific for online key management.
The case is that if the keyslot used to open the image in first place is re=
moved, it can be used to specify
the password to retrieve the master key from one of existing keyslots, sinc=
e the driver doesn't officially
keep the master key all the time (it can be in theory only loaded in hardwa=
re crypto device)

That is why for adding a new keyslot, the secret that was used to open the =
image is tried first, and if it
doesn't open a keyslot, the 'unlock-secret' can be used instead. This can b=
e thought of as the 'current password'
that is need to update the password on many web forums.


One of the concerns that was raised during the review was that amend interf=
ace for luks that I propose is
different from the amend inteface used currently for qcow2.

qcow2 amend interface specifies all the format options, thus overwrites the=
 existing options.
Thus it seems natural to make the luks amend interface work the same way, t=
hat it receive an array
of 8 slots, and for each slot specify if it is active, and if true what pas=
sword to put in it.
This does allow to add and erase the keyslots, but it doesn't allow:

   * add a password without knowing all other passwords that exist in exist=
ing keyslots
     this can be mitigated by specifying which keyslots to modify for examp=
le by omitting the
     keyslots that shouldn't be touched from the array (passing null placeh=
older instead)
     but then it already doesn't follow the 'specify all the options each t=
ime' principle.

   * erase all keyslots matching a password - this is really hard to do usi=
ng this approach,
     unless we give user some kind of api to try each keyslot with given pa=
ssword,
     which is kind of ugly and might be racy as well.


So what do you think?

Best regards,
=09Maxim Levitsky






